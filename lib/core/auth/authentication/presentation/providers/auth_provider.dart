import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:taskify_app/core/auth/authentication/data/datasource/auth_remote_datasource.dart';
import 'package:taskify_app/core/auth/authentication/data/repository/auth_repository_impl.dart';
import 'package:taskify_app/core/auth/authentication/domain/entity/auth_entity.dart';
import 'package:taskify_app/core/auth/authentication/domain/repository/auth_repository.dart';
import 'package:taskify_app/core/error/api_error_parser.dart';
import 'package:taskify_app/core/network/api_provider.dart';


// Remote Datasource Provider
final authRemoteDatasourceProvider =
    Provider<AuthRemoteDatasource>((ref) {
  return AuthRemoteDatasource(
    ref.watch(apiClientProvider),
  );
});


// Repository Provider
final authRepositoryProvider =
    Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    ref.watch(authRemoteDatasourceProvider),
  );
});


// Auth StateNotifier Provider
final authProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    ref.watch(authRepositoryProvider),
  );
});


// State
class AuthState {
  final bool isLoading;
  final AuthEntity? user;
  final String? token;
  final String? error;
  final String? successMessage;

  const AuthState({
    this.isLoading = false,
    this.user,
    this.token,
    this.error,
    this.successMessage,
  });


  AuthState copyWith({
    bool? isLoading,
    AuthEntity? user,
    String? token,
    String? error,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      token: token ?? this.token,
      error: clearError ? null : (error ?? this.error),
      successMessage: clearSuccess
          ? null
          : (successMessage ?? this.successMessage),
    );
  }
}


// Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;


  AuthNotifier(this._repository)
      : super(const AuthState());


  // Register
  Future<bool> register(AuthEntity auth) async {
    state = state.copyWith(
      isLoading: true,
      clearError: true,
      clearSuccess: true,
    );

    try {
      await _repository.register(auth);

      state = state.copyWith(
        isLoading: false,
        successMessage: "Registered successfully",
      );

      return true;
    } catch (error) {
      final failure = ApiErrorParser.parse(error);

      state = state.copyWith(
        isLoading: false,
        error: failure.message,
      );

      return false;
    }
  }


  // Login
  Future<bool> login(AuthEntity auth) async {
    state = state.copyWith(
      isLoading: true,
      clearError: true,
      clearSuccess: true,
    );

    try {
      final user = await _repository.login(auth);

      state = state.copyWith(
        isLoading: false,
        user: user,
        token: user.token,
        successMessage: "Login successful",
      );

      return true;
    } catch (error) {
      final failure = ApiErrorParser.parse(error);

      state = state.copyWith(
        isLoading: false,
        error: failure.message,
      );

      return false;
    }
  }


  // Refresh Token
  Future<void> refreshToken() async {
    try {
      final user = await _repository.refreshToken();

      state = state.copyWith(
        user: user,
        token: user.token,
      );
    } catch (error) {
      final failure = ApiErrorParser.parse(error);

      state = state.copyWith(
        error: failure.message,
      );
    }
  }


  // Logout
  Future<void> logout(AuthEntity auth) async {
    state = state.copyWith(
      isLoading: true,
      clearError: true,
    );

    try {
      await _repository.logout(auth);

      state = const AuthState(
        successMessage: "Logout successful",
      );

    } catch (error) {
      final failure = ApiErrorParser.parse(error);

      state = state.copyWith(
        isLoading: false,
        error: failure.message,
      );
    }
  }


  // Forgot Password
  Future<bool> forgotPassword(AuthEntity auth) async {
    try {
      state = state.copyWith(
        isLoading: true,
        clearError: true,
      );

      await _repository.forgotPassword(auth);

      state = state.copyWith(
        isLoading: false,
        successMessage: "OTP sent successfully",
      );

      return true;

    } catch(error) {
      final failure = ApiErrorParser.parse(error);

      state = state.copyWith(
        isLoading:false,
        error: failure.message,
      );

      return false;
    }
  }


  // Reset Password
  Future<bool> resetPassword(AuthEntity auth) async {
    try {
      state = state.copyWith(
        isLoading:true,
        clearError:true,
      );

      await _repository.resetPassword(auth);

      state = state.copyWith(
        isLoading:false,
        successMessage:"Password reset successful",
      );

      return true;

    } catch(error){
      final failure = ApiErrorParser.parse(error);

      state = state.copyWith(
        isLoading:false,
        error:failure.message,
      );

      return false;
    }
  }


  // Change Password
  Future<bool> changePassword(AuthEntity auth) async {
    try {
      await _repository.changePassword(auth);

      state = state.copyWith(
        successMessage:"Password changed successfully",
      );

      return true;

    } catch(error){
      final failure = ApiErrorParser.parse(error);

      state = state.copyWith(
        error:failure.message,
      );

      return false;
    }
  }


  // Verify Email
  Future<bool> verifyEmail(AuthEntity auth) async {
    try {
      await _repository.verifyEmail(auth);

      state = state.copyWith(
        successMessage:"Email verified successfully",
      );

      return true;

    } catch(error){
      final failure = ApiErrorParser.parse(error);

      state = state.copyWith(
        error:failure.message,
      );

      return false;
    }
  }


  // Resend OTP
  Future<bool> resendOtp(AuthEntity auth) async {
    try {
      await _repository.resendOtp(auth);

      state = state.copyWith(
        successMessage:"OTP sent again",
      );

      return true;

    } catch(error){
      final failure = ApiErrorParser.parse(error);

      state = state.copyWith(
        error:failure.message,
      );

      return false;
    }
  }


  void clearState() {
    state = const AuthState();
  }
}