import 'package:hobby_life_app/repository/hobby_history_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final hobbyHistoryProvider = FutureProvider.autoDispose<HobbyHistoryRepository>((ref) => HobbyHistoryRepository());