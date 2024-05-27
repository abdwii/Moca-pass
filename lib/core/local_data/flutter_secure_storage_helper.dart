import 'package:alafein/features/auth/login/model/login_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CredentialStorage {
  final FlutterSecureStorage _storage;

  CredentialStorage(this._storage);
  static const String _key = 'user_credentials';
  LoginModel? _cachedUser;

  Future<LoginModel?> read() async {
    if (_cachedUser != null) {
      return _cachedUser;
    }
    final json = await _storage.read(key: _key);
    if (json == null) {
      return null;
    }
    try {
      return _cachedUser = LoginModel.fromJson(json);
    } on FormatException {
      return null;
    }
  }

  Future<void> save(LoginModel user) {
    _cachedUser = user;
    return _storage.write(key: _key, value: user.toJson().toString());
  }

  Future<void> clear() {
    _cachedUser = null;
    return _storage.delete(key: _key);
  }
}
