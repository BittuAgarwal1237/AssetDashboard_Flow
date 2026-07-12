import 'package:get/get.dart';
import '../model/user_model.dart';
import '../auth/auth.dart';

enum AuthStatus { initial, loading, success, error }

class AuthController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final Rx<AuthStatus> status = AuthStatus.initial.obs;
  final RxString errorMessage = ''.obs;
  final Rx<UserModel?> user = Rx<UserModel?>(null);

  bool get isLoading => status.value == AuthStatus.loading;
  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    _setLoading();
    try {
      final result = await _authRepository.signUpWithEmail(
        name: name,
        email: email,
        password: password,
      );
      user.value = result;
      status.value = AuthStatus.success;
      return true;
    } catch (e) {
      _setError(e.toString().replaceFirst('Exception: ', ''));
      return false;
    }
  }

  Future<bool> login({required String email, required String password}) async {
    _setLoading();
    try {
      final result = await _authRepository.signInWithEmail(
        email: email,
        password: password,
      );
      user.value = result;
      status.value = AuthStatus.success;
      return true;
    } catch (e) {
      _setError(e.toString().replaceFirst('Exception: ', ''));
      return false;
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
    user.value = null;
    status.value = AuthStatus.initial;
  }

  void _setLoading() {
    status.value = AuthStatus.loading;
    errorMessage.value = '';
  }

  void _setError(String message) {
    status.value = AuthStatus.error;
    errorMessage.value = message;
  }
}