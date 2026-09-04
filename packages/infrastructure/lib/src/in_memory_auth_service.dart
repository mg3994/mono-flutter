import 'package:domain/domain.dart';

class InMemoryAuthService implements IAuthService {
  final bool _authenticated;

  InMemoryAuthService({bool authenticated = false})
    : _authenticated = authenticated;

  @override
  Future<bool> isAuthenticated() async => _authenticated;
}
