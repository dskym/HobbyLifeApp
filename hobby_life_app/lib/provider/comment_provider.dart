import 'package:hobby_life_app/model/comment_model.dart';
import 'package:hobby_life_app/repository/comment_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'comment_provider.g.dart';

final commentRepositoryProvider = Provider<CommentRepository>((ref) => CommentRepository());

@riverpod
class CommentList extends _$CommentList {
  @override
  Future<List<CommentModel>> build(String communityId, String contentId) async {
    return ref.read(commentRepositoryProvider).getAllComment(communityId: communityId, contentId: contentId);
  }

  Future<void> createComment({required String communityId, required String contentId, required String detail, required int? originCommentId}) async {
    final commentRepository = ref.read(commentRepositoryProvider);
    final commentModel = await commentRepository.createComment(communityId: communityId, contentId: contentId, detail: detail, originCommentId: originCommentId);
    final previousState = await future;
    state = AsyncData([...previousState, commentModel]);
  }

  Future<void> deleteComment({required String communityId, required String contentId, required String commentId}) async {
    final commentRepository = ref.read(commentRepositoryProvider);
    await commentRepository.deleteComment(communityId: communityId, contentId: contentId, commentId: commentId);
    final previousState = await future;
    state = AsyncData(previousState.where((element) => element.commentId.toString() != commentId).toList());
  }

  Future<void> updateComment({required String communityId, required String contentId, required String commentId, required String detail, required int originCommentId}) async {
    final commentRepository = ref.read(commentRepositoryProvider);
    final commentModel = await commentRepository.updateComment(communityId: communityId, contentId: contentId, commentId: commentId, detail: detail, originCommentId: originCommentId);
    final previousState = await future;
    state = AsyncData(previousState.map((element) {
      if (element.commentId.toString() == commentId) {
        return element.copyWith(detail: detail);
      }
      return element;
    }).toList());
  }
}