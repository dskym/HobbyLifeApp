import 'package:hobby_life_app/model/comment_model.dart';
import 'package:hobby_life_app/provider/community_provider.dart';
import 'package:hobby_life_app/provider/content_provider.dart';
import 'package:hobby_life_app/repository/comment_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'comment_provider.g.dart';

final commentRepositoryProvider = Provider<CommentRepository>((ref) => CommentRepository());

@riverpod
class CommentList extends _$CommentList {
  @override
  Future<List<CommentModel>> build(int communityId, int contentId) async {
    final communityModel = await ref.watch(communityProvider(communityId).future);
    final contentModel = await ref.watch(contentProvider(communityId, contentId).future);
    return ref.watch(commentRepositoryProvider).getAllComment(communityId: communityModel.communityId, contentId: contentModel.contentId);
  }

  Future<void> createComment({required int communityId, required int contentId, required String detail, required int? originCommentId}) async {
    final commentRepository = ref.watch(commentRepositoryProvider);
    final commentModel = await commentRepository.createComment(communityId: communityId, contentId: contentId, detail: detail, originCommentId: originCommentId);
    final previousState = await future;
    state = AsyncData([...previousState, commentModel]);
  }

  Future<void> deleteComment({required int communityId, required int contentId, required int commentId}) async {
    final commentRepository = ref.watch(commentRepositoryProvider);
    await commentRepository.deleteComment(communityId: communityId, contentId: contentId, commentId: commentId);
    final previousState = await future;
    state = AsyncData(previousState.where((element) => element.commentId != commentId).toList());
  }

  Future<void> updateComment({required int communityId, required int contentId, required int commentId, required String detail, required int? originCommentId}) async {
    final commentRepository = ref.watch(commentRepositoryProvider);
    final commentModel = await commentRepository.updateComment(communityId: communityId, contentId: contentId, commentId: commentId, detail: detail, originCommentId: originCommentId);
    final previousState = await future;
    state = AsyncData(previousState.map((element) {
      if (element.commentId == commentId) {
        return commentModel;
      }
      return element;
    }).toList());
  }
}