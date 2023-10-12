import 'package:hobby_life_app/repository/user_auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final userAuthProvider = FutureProvider.autoDispose<UserAuthRepository>((ref) => UserAuthRepository());