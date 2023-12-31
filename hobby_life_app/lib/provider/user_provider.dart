import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hobby_life_app/model/user_model.dart';
import 'package:hobby_life_app/repository/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) => UserRepository());

@riverpod
class User extends _$User {
  @override
  FutureOr<UserModel> build() async {
    return ref.watch(userRepositoryProvider).getUser();
  }
}