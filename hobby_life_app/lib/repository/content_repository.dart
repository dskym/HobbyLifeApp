import 'package:dio/dio.dart';
import 'package:hobby_life_app/model/common_response_model.dart';
import 'package:hobby_life_app/model/content_model.dart';

class ContentRepository {
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:8080',
    connectTimeout: const Duration(seconds: 1).inMilliseconds,
    receiveTimeout: const Duration(seconds: 1).inMilliseconds,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

Future<ContentModel> createContent({required String communityId, required String title, required String detail}) async {
    final response = await _dio.post('/community/$communityId/content', data: {
      'title': title,
      'detail': detail,
    });
    CommonResponseModel<ContentModel> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }

Future<ContentModel> deleteContent({required String communityId, required String contentId}) async {
    final response = await _dio.delete('/community/$communityId/content/$contentId');
    CommonResponseModel<ContentModel> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }

Future<ContentModel> updateContent({required String communityId, required String contentId, required String title, required String detail}) async {
    final response = await _dio.put('/community/$communityId/content/$contentId', data: {
      'title': title,
      'detail': detail,
    });
    CommonResponseModel<ContentModel> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }

Future<ContentModel> getContent({required String communityId, required String contentId}) async {
    final response = await _dio.get('/community/$communityId/content/$contentId');
    CommonResponseModel<ContentModel> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }

Future<List<ContentModel>> getAllContent({required String communityId}) async {
    final response = await _dio.get('/community/$communityId/content');
    CommonResponseModel<List<ContentModel>> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }
}