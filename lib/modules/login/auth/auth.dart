import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/user_model.dart';

class AuthRepository {
  final SupabaseClient _client = Supabase.instance.client;
  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );

      final user = response.user;
      if (user == null) {
        throw Exception('Sign up fail.');
      }

      return UserModel.fromSupabaseUser(user);
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }

  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;
      if (user == null) {
        throw Exception('Login fail. Check Email/password');
      }

      return UserModel.fromSupabaseUser(user);
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }
  Future<void> signOut() async {
    await _client.auth.signOut();
  }
  UserModel? get currentUser {
    final user = _client.auth.currentUser;
    if (user == null) return null;
    return UserModel.fromSupabaseUser(user);
  }

  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;
}