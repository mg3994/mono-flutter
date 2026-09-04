import 'package:test/test.dart';
import 'package:domain/domain.dart';

class FakeAuthService implements IAuthService {
  @override
  Future<bool> isAuthenticated() async => true;
}

void main() {
  test('FakeAuthService returns true for isAuthenticated', () async {
    final authService = FakeAuthService();
    expect(await authService.isAuthenticated(), isTrue);
  });
}
