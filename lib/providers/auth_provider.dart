import 'package:flutter/foundation.dart';

import '../core/constants/app_constants.dart';

class AuthProvider extends ChangeNotifier {
  static const demoEmail = 'user@gmail.com';
  static const demoPassword = '123456';

  bool _isLoggedIn = false;
  bool _isLoading = false;
  String? _error;

  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> login({required String email, required String password}) async {
    _setLoading(true);
    _error = null;
    try {
      await Future<void>.delayed(AppConstants.mockNetworkDelay);

      if (email.toLowerCase() != demoEmail || password != demoPassword) {
        _error = 'Invalid email or password';
        return;
      }

      _isLoggedIn = true;
    } catch (_) {
      _error = 'Login failed';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _error = null;
    try {
      await Future<void>.delayed(AppConstants.mockNetworkDelay);
      _isLoggedIn = true;
    } catch (_) {
      _error = 'Registration failed';
    } finally {
      _setLoading(false);
    }
  }

  void logout() {
    _isLoggedIn = false;
    _error = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
