import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/repositories/auth_repository.dart';

enum SignupResult { success, confirmationRequired, error }

class SignupViewModel extends ChangeNotifier {
  final AuthRepository _repository;

  SignupViewModel({required AuthRepository repository}) : _repository = repository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<SignupResult> signUp(String name, String email, String password) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _errorMessage = "All fields are required";
      return SignupResult.error;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _repository.signUp(
        email: email,
        password: password,
        name: name,
      );

      // If session is null but user is created, it means email confirmation is enabled
      if (response.session == null && response.user != null) {
        return SignupResult.confirmationRequired;
      }

      return SignupResult.success;
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint("Signup Error: $e");
      return SignupResult.error;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool get isAuthenticated => _repository.currentSession != null;
}
