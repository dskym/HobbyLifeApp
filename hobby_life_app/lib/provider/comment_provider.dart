import 'package:hobby_life_app/model/comment_model.dart';
import 'package:hobby_life_app/repository/comment_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'comment_provider.g.dart';

final commentRepositoryProvider = Provider<CommentRepository>((ref) => CommentRepository());

@riverpod
class Comment extends _$Comment {
  @override
  Future<CommentModel> build(String communityId, String contentId) async {
    return ref.read(commentRepositoryProvider).getComment(communityId: communityId, contentId: contentId);
  }

  Future<void> createComment({required String communityId, required String contentId, required String detail, required int originCommentId}) async {
    final commentRepository = ref.read(commentRepositoryProvider);
    final commentModel = await commentRepository.createComment(communityId: communityId, contentId: contentId, detail: detail, originCommentId: originCommentId);
    state = AsyncData(commentModel);
  }

  Future<void> deleteComment({required String communityId, required String contentId, required String commentId}) async {
    final commentRepository = ref.read(commentRepositoryProvider);
    await commentRepository.deleteComment(communityId: communityId, contentId: contentId, commentId: commentId);
  }

  Future<void> updateComment({required String communityId, required String contentId, required String commentId, required String detail, required int originCommentId}) async {
    final commentRepository = ref.read(commentRepositoryProvider);
    final commentModel = await commentRepository.updateComment(communityId: communityId, contentId: contentId, commentId: commentId, detail: detail, originCommentId: originCommentId);
    state = AsyncData(commentModel);
  }
}