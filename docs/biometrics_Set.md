# Biometric Lock

How fingerprint unlock and the inactivity gate were added to Taskify, and the
exact steps to rebuild it from a blank branch next time.

**Stack:** Flutter · Riverpod · `local_auth` ^2.3.0 · go_router
**Shipped:** 2026-08-25

---

## 1. The idea

Biometrics is a **device-local re-entry gate** the user opts into from
Profile. It never talks to the backend and never issues or checks a token —
it just decides whether the already-logged-in UI is allowed to be *seen*
right now.

| Already existed | Added now |
|---|---|
| Access & refresh tokens. `AuthInterceptor` attaches the access token to every request and silently rotates it on a 401 using the refresh token. Untouched by this feature. | A fingerprint prompt that appears when the app returns from the background after sitting idle past the lock timeout — purely a client-side screen lock on top of a session that's already valid. |

---

## 2. How it fits together

```
App paused ──(later)──▶ App resumed
 (TokenStorage.setLastActiveAt())   │
                                     ▼
                    elapsed ≥ timeout && biometric on?
                                     │
                  ┌──────────no──────┴──────yes──────────┐
                  ▼                                       ▼
        Current route stays visible,          appLockProvider.lock()
              untouched                    BiometricLockScreen overlays UI
                                                       │
                                                       ▼
                                     BiometricService.authenticate()
                                     success → unlock()  ·  fail → retry
```

The only decision the gate makes: has the app been backgrounded past the
lock timeout while biometrics is on. Everything else — auth state, token
refresh, routing — is untouched.

---

## 3. Build it, step by step

Same order it was actually built in — each step compiles on its own before
the next one leans on it.

### 01. Add the plugin

`pubspec.yaml`

```yaml
# Biometric Authentication
local_auth: ^2.3.0
```

### 02. Platform plumbing

`android/` · `ios/Runner/Info.plist`

Three platform requirements `local_auth` won't work without. Miss any one
and it fails silently or crashes on the prompt.

```kotlin
// MainActivity.kt — local_auth needs a FragmentActivity host
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity : FlutterFragmentActivity()
```

```xml
<!-- AndroidManifest.xml -->
<uses-permission android:name="android.permission.USE_BIOMETRIC"/>
```

```kotlin
// build.gradle.kts — local_auth requires API 23+
minSdk = maxOf(flutter.minSdkVersion, 23)
```

```xml
<!-- Info.plist — Face ID needs a usage string or iOS rejects the call -->
<key>NSFaceIDUsageDescription</key>
<string>Taskify uses Face ID to quickly and securely unlock the app.</string>
```

### 03. Pick the lock timeout

`lib/core/constants/app_constants.dart`

One named constant so the number lives in exactly one place.

```dart
/// How long the app can sit in the background before biometric
/// re-authentication is required to resume a session.
static const Duration biometricLockTimeout = Duration(minutes: 3);
```

### 04. Persist the two preferences that matter

`lib/core/storage/token_storage.dart`

Neither value is sensitive, so both live in `SharedPreferences`, not secure
storage — added next to the existing token methods so there's one place
that owns local auth state.

```dart
Future<bool> isBiometricEnabled() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(_biometricEnabledKey) ?? false;
}

Future<void> setBiometricEnabled(bool enabled) async { /* ... */ }

// last moment the app was foregrounded — the clock the lock timeout reads
Future<void> setLastActiveAt(DateTime time) async { /* ... */ }
Future<DateTime?> getLastActiveAt() async { /* ... */ }
```

> ⚠️ **On `clearAll()`** — the biometric preference is deliberately *not*
> cleared on logout, only the timestamp is. Nobody wants to re-flip the
> toggle every time they sign back in.

### 05. Wrap the plugin

`lib/core/auth/biometric/biometric_service.dart`

Nothing else in the app touches `LocalAuthentication` directly — every
failure mode collapses to a plain `bool`.

```dart
Future<bool> authenticate(String reason) async {
  try {
    return await _localAuth.authenticate(
      localizedReason: reason,
      options: const AuthenticationOptions(
        biometricOnly: false,  // falls back to device PIN/pattern
        stickyAuth: true,      // survives the OS prompt backgrounding the app
      ),
    );
  } catch (_) {
    return false;
  }
}
```

### 06. Expose it through Riverpod

`lib/core/auth/biometric/biometric_provider.dart`

Four small providers, each with one job:

```dart
biometricServiceProvider    // the wrapper above
biometricAvailableProvider  // does this device even have the hardware
biometricEnabledProvider    // StateNotifier<bool> — the user's saved toggle
appLockProvider             // StateNotifier<bool> — is the lock screen showing right now
```

### 07. Build the lock screen

`lib/core/auth/biometric/biometric_lock_screen.dart`

A full-bleed `Material` screen (not a route — it's an overlay, see step 9)
that auto-triggers the prompt on mount, retries on failure, and offers
**Log out instead** as the escape hatch if the person can't authenticate.

```dart
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) => _attemptUnlock());
}

Future<void> _attemptUnlock() async {
  final success = await ref.read(biometricServiceProvider)
      .authenticate('Unlock Taskify to continue');
  if (success) ref.read(appLockProvider.notifier).unlock();
}
```

### 08. Watch the app lifecycle

`lib/core/auth/biometric/app_lock_gate.dart`

A `WidgetsBindingObserver` that stamps a timestamp on every pause and
re-checks it on every resume — plus a cold-start check, since a
killed-and-relaunched app never fires `resumed`.

```dart
void didChangeAppLifecycleState(AppLifecycleState state) {
  switch (state) {
    case AppLifecycleState.paused:
    case AppLifecycleState.inactive:
    case AppLifecycleState.hidden:
      _backgroundedAt ??= DateTime.now();
      tokenStorage.setLastActiveAt(DateTime.now());
    case AppLifecycleState.resumed:
      final backgroundedAt = _backgroundedAt;
      _backgroundedAt = null;
      _evaluateLock(backgroundedAt);
    case AppLifecycleState.detached:
  }
}

Future<void> _evaluateLock(DateTime? sinceWhen) async {
  if (sinceWhen == null) return;
  if (ref.read(authProvider).user == null) return;      // not logged in — nothing to guard
  if (!ref.read(biometricEnabledProvider)) return;      // user hasn't opted in
  if (DateTime.now().difference(sinceWhen) >= AppConstants.biometricLockTimeout) {
    ref.read(appLockProvider.notifier).lock();
  }
}
```

### 09. Mount the gate above the router

`lib/main.dart`

`MaterialApp.router`'s `builder` wraps *every* route, so the lock overlay
works no matter which screen — admin shell, user shell, a modal — was on
screen when the timeout hit. No route or redirect needed.

```dart
MaterialApp.router(
  /* ...theme, routerConfig... */
  builder: (context, child) =>
      AppLockGate(child: child ?? const SizedBox.shrink()),
)
```

### 10. Let the user opt in

`lib/features/shell/presentation/pages/shell_profile_page.dart`

One `AppSwitch`, shared by both Profile and Admin Profile since they render
the same widget. Hidden entirely on hardware that can't do biometrics;
turning it *on* requires a real successful scan first, turning it *off* is
immediate.

```dart
onChanged: (value) async {
  if (!value) { await notifier.setEnabled(false); return; }
  final confirmed = await ref.read(biometricServiceProvider)
      .authenticate('Confirm your fingerprint to enable biometric login');
  if (confirmed) await notifier.setEnabled(true);
  else AppSnackBar.error(context, 'Could not verify your fingerprint. Please try again.');
}
```

---

## 4. File map

| File | Change | Purpose |
|---|---|---|
| `pubspec.yaml` | edit | adds `local_auth` |
| `android/…/MainActivity.kt` | edit | `FlutterActivity` → `FlutterFragmentActivity` |
| `android/…/AndroidManifest.xml` | edit | `USE_BIOMETRIC` permission |
| `android/app/build.gradle.kts` | edit | bumps `minSdk` to 23 |
| `ios/Runner/Info.plist` | edit | `NSFaceIDUsageDescription` |
| `lib/core/constants/app_constants.dart` | edit | `biometricLockTimeout` |
| `lib/core/storage/token_storage.dart` | edit | enabled flag + last-active timestamp |
| `lib/core/auth/biometric/biometric_service.dart` | new | wraps `LocalAuthentication` |
| `lib/core/auth/biometric/biometric_provider.dart` | new | Riverpod providers |
| `lib/core/auth/biometric/biometric_lock_screen.dart` | new | the lock overlay UI |
| `lib/core/auth/biometric/app_lock_gate.dart` | new | lifecycle observer + decision |
| `lib/main.dart` | edit | mounts `AppLockGate` |
| `lib/features/shell/presentation/pages/shell_profile_page.dart` | edit | the opt-in toggle |

---

## 5. Verify it works

Needs a real device or an emulator with an enrolled fingerprint — the
biometric prompt can't be faked in a plain simulator.

- [ ] `flutter pub get && flutter analyze` — clean, no new warnings.
- [ ] `flutter build apk --debug` — confirms the Gradle/manifest changes actually link.
- [ ] Profile → toggle appears only on hardware with biometrics enrolled; flipping it on prompts a real scan before it sticks.
- [ ] Background the app, wait past the timeout in `app_constants.dart`, resume — lock screen appears over whatever screen was open.
- [ ] Successful scan dismisses the lock and the app resumes exactly where it was — no navigation, no reload.
- [ ] Log out, log back in — the toggle is still on; only the inactivity clock reset.
- [ ] Turn the toggle off — backgrounding no longer triggers the lock screen at all.

---

## 6. Decisions worth remembering

The non-obvious calls, so future-me doesn't relitigate them.

**Overlay, not a route.**
The lock screen is stacked in a `Stack` inside `AppLockGate`, not pushed via
`go_router`. A route would need every screen to cooperate with a redirect;
an overlay just sits on top of whatever's already rendered — same pattern
the app already uses for the shell-level `auth.user == null` guards in
`TaskifyShell` / `AdminShell`.

**`biometricOnly: false`.**
Lets the OS fall back to device PIN/pattern/password if the fingerprint
sensor fails or isn't enrolled in the moment. Locking someone out of an
already-authenticated session because a sensor smudged is worse than the
marginal security gain.

**Tokens stay someone else's problem.**
The lock never reads or refreshes tokens itself. If the refresh token has
actually expired while the app was away, the existing `AuthInterceptor`
still clears storage on the next 401 the normal way — the biometric gate
and the token lifecycle never need to know about each other.

**Preference outlives logout.**
`TokenStorage.clearAll()` wipes tokens and the last-active timestamp, but
not the biometric flag. Re-enabling biometrics after every login would
defeat the point of it being a convenience feature.
