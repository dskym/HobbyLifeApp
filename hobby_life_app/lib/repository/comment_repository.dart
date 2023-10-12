import 'package:dio/dio.dart';
import 'package:hobby_life_app/model/comment_model.dart';
import 'package:hobby_life_app/model/common_response_model.dart';

class CommentRepository {
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:8080',
    connectTimeout: const Duration(seconds: 1).inMilliseconds,
    receiveTimeout: const Duration(seconds: 1).inMilliseconds,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  Future<CommentModel> createComment({required String communityId, required String contentId, required String detail, required int originCommentId}) async {
    final response = await _dio.post('/community/$communityId/content/$contentId/comment', data: {
      'detail': detail,
      'originCommentId': originCommentId,
    });
    CommonResponseModel<CommentModel> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }

  Future<CommentModel> deleteComment({required String communityId, required String contentId, required String commentId}) async {
    final response = await _dio.delete('/community/$communityId/content/$contentId/comment/$commentId');
    CommonResponseModel<CommentModel> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }

  Future<CommentModel> updateComment({required String communityId, required String contentId, required String commentId, required String detail, required int originCommentId}) async {
    final response = await _dio.put('/community/$communityId/content/$contentId/comment/$commentId', data: {
      'detail': detail,
      'originCommentId': originCommentId,
    });
    CommonResponseModel<CommentModel> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }

  Future<CommentModel> getComment({required String communityId, required String contentId}) async {
    final response = await _dio.get('/community/$communityId/content/$contentId/comment/');
    CommonResponseModel<CommentModel> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }
}