import 'package:dio/dio.dart';
import 'package:hobby_life_app/model/comment_model.dart';
import 'package:hobby_life_app/model/common_response_model.dart';

class CommentRepository {
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8080',
    connectTimeout: const Duration(seconds: 1).inMilliseconds,
    receiveTimeout: const Duration(seconds: 1).inMilliseconds,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyOSIsImV4cCI6MTY5NzIxNjgzMH0.Bg2R5wfY7izCl61hiXlKExZGRDOhCAmL7doOlTGvDjqIsPg0SRhLjwPGY-d1uDjoeI5A0KMoYsx_J31vIkwqMA',
    },
  ));

  Future<CommentModel> createComment({required String communityId, required String contentId, required String detail, required int originCommentId}) async {
    final response = await _dio.post('/community/$communityId/content/$contentId/comment', data: {
      'detail': detail,
      'originCommentId': originCommentId,
    });
    print("createComment : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return CommentModel.fromJson(commonResponse.data!);
  }

  Future<CommentModel> deleteComment({required String communityId, required String contentId, required String commentId}) async {
    final response = await _dio.delete('/community/$communityId/content/$contentId/comment/$commentId');
    print("deleteComment : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return CommentModel.fromJson(commonResponse.data!);
  }

  Future<CommentModel> updateComment({required String communityId, required String contentId, required String commentId, required String detail, required int originCommentId}) async {
    final response = await _dio.put('/community/$communityId/content/$contentId/comment/$commentId', data: {
      'detail': detail,
      'originCommentId': originCommentId,
    });
    print("updateComment : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return CommentModel.fromJson(commonResponse.data!);
  }

  Future<CommentModel> getComment({required String communityId, required String contentId}) async {
    final response = await _dio.get('/community/$communityId/content/$contentId/comment/');
    print("getComment : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return CommentModel.fromJson(commonResponse.data!);
  }
}