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
      'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyIiwiZXhwIjoxNjk4MDQzOTg1fQ.WcOUu29GimufWaaKmlnlnuTudHLPm3FU8gISNDd6S5I3FX-8iLeXycTe1Wob1dR2gUTQAGsnf6s0zgakSZprEA',
    },
  ));

  Future<CommentModel> createComment({required int communityId, required int contentId, required String detail, required int? originCommentId}) async {
    final response = await _dio.post('/community/$communityId/content/$contentId/comment', data: {
      'detail': detail,
      'originCommentId': originCommentId,
    });
    print("createComment : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return CommentModel.fromJson(commonResponse.data!);
  }

  Future<void> deleteComment({required int communityId, required int contentId, required int commentId}) async {
    await _dio.delete('/community/$communityId/content/$contentId/comment/$commentId');
    print("deleteComment");
  }

  Future<CommentModel> updateComment({required int communityId, required int contentId, required int commentId, required String detail, required int? originCommentId}) async {
    final response = await _dio.put('/community/$communityId/content/$contentId/comment/$commentId', data: {
      'detail': detail,
      'originCommentId': originCommentId,
    });
    print("updateComment : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return CommentModel.fromJson(commonResponse.data!);
  }

  Future<List<CommentModel>> getAllComment({required int communityId, required int contentId}) async {
    final response = await _dio.get('/community/$communityId/content/$contentId/comment');
    print("getComment : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return List.from(commonResponse.data?.map((e) => CommentModel.fromJson(e)) ?? []);
  }
}