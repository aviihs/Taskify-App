import 'package:flutter_test/flutter_test.dart';
import 'package:taskify_app/main.dart';

void main() {
  testWidgets('app starts and shows the login screen', (tester) async {
    await tester.pumpWidget(const TaskifyApp());

    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Sign in to continue'), findsOneWidget);
  });
}
