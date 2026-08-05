import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskify_app/main.dart';

void main() {
  testWidgets('app starts and shows the login screen', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: TaskifyApp()));

    expect(find.text('Sign In to your Account'), findsOneWidget);
    expect(
      find.text('Enter your email and password to sign in'),
      findsOneWidget,
    );
  });
}
