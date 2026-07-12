import 'package:supabase_flutter/supabase_flutter.dart';

class UserModel {
  final String id;
  final String? email;
  final DateTime? createdAt;

  UserModel({
    required this.id,
    required this.email,
    required this.createdAt,
  });
  factory UserModel.fromSupabaseUser(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      createdAt: DateTime.tryParse(user.createdAt),
    );
  }
}