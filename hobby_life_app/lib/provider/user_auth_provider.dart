import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hobby_life_app/repository/user_auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final userAuthRepositoryProvider = Provider<UserAuthRepository>((ref) => UserAuthRepository());
final isLoginProvider = StateProvider<bool>((ref) => false);
