import 'package:test/test.dart';
import 'package:infrastructure/infrastructure.dart';

void main() {
  test('InMemoryAuthService reflects configured state', () async {
    final service = InMemoryAuthService(authenticated: true);
    expect(await service.isAuthenticated(), isTrue);
  });
}
