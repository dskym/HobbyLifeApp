import 'package:hobby_life_app/repository/content_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final contentProvider = FutureProvider.autoDispose<ContentRepository>((ref) => ContentRepository());