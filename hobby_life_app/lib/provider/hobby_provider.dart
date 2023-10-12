import 'package:hobby_life_app/repository/hobby_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final hobbyProvider = FutureProvider.autoDispose<HobbyRepository>((ref) => HobbyRepository());