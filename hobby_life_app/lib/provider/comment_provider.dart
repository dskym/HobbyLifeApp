import 'package:hobby_life_app/repository/comment_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final commentProvider = FutureProvider.autoDispose<CommentRepository>((ref) => CommentRepository());