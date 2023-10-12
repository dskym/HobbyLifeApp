import 'package:hobby_life_app/repository/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final userProvider = FutureProvider.autoDispose<UserRepository>((ref) => UserRepository());