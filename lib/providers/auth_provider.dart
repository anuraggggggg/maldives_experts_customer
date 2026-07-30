import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
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
      await Future<void>.delayed(const Duration(milliseconds: 400));
      _isLoggedIn = true;
    } catch (_) {
      _error = 'Login failed';
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
