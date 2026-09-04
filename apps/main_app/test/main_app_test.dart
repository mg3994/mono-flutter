import 'package:flutter_test/flutter_test.dart';
import 'package:infrastructure/infrastructure.dart';
import 'package:main_app/main.dart';

void main() {
  testWidgets('MainApp smoke test renders authenticated state', (
    WidgetTester tester,
  ) async {
    final authService = InMemoryAuthService(authenticated: true);
    await tester.pumpWidget(MainApp(authService: authService));
    await tester.pumpAndSettle();

    expect(find.text('Authenticated: true'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
  });
}
