import 'package:flutter/material.dart';
import '../../data/repositories/auth_repository.dart';

class ResetPasswordViewModel extends ChangeNotifier {
  final AuthRepository _repository;

  ResetPasswordViewModel({required AuthRepository repository}) : _repository = repository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> sendResetLink(String email) async {
    if (email.isEmpty) return false;
    
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.sendResetLink(email);
      return true;
    } catch (e) {
      debugPrint("Reset Password Error: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
