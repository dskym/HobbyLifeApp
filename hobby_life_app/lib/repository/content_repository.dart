import 'package:dio/dio.dart';
import 'package:hobby_life_app/model/common_response_model.dart';
import 'package:hobby_life_app/model/content_model.dart';

class ContentRepository {
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8080',
    connectTimeout: const Duration(seconds: 1).inMilliseconds,
    receiveTimeout: const Duration(seconds: 1).inMilliseconds,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyIiwiZXhwIjoxNjk3NTQyNzMzfQ.h2N4Q0AHtbbkwTLLxOl9aWJGjgsXocOcwa9gQBqR4b85zK9xWz2gmjbxQqP9oQUxquAXXTVNLo2YIyDYVZhPww',
    },
  ));

Future<ContentModel> createContent({required int communityId, required String title, required String detail}) async {
    final response = await _dio.post('/community/$communityId/content', data: {
      'title': title,
      'detail': detail,
    });
    print("createContent : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return ContentModel.fromJson(commonResponse.data!);
  }

Future<void> deleteContent({required int communityId, required int contentId}) async {
    final response = await _dio.delete('/community/$communityId/content/$contentId');
    print("deleteContent : ${response.data}");
  }

Future<ContentModel> updateContent({required int communityId, required int contentId, required String title, required String detail}) async {
    final response = await _dio.put('/community/$communityId/content/$contentId', data: {
      'title': title,
      'detail': detail,
    });
    print("updateContent : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return ContentModel.fromJson(commonResponse.data!);
  }

Future<ContentModel> getContent({required int communityId, required int contentId}) async {
    final response = await _dio.get('/community/$communityId/content/$contentId');
    print("getContent : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return ContentModel.fromJson(commonResponse.data!);
  }

Future<List<ContentModel>> getAllContent({required int communityId}) async {
    final response = await _dio.get('/community/$communityId/content');
    print("getAllContent : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return List.from(commonResponse.data?.map((e) => ContentModel.fromJson(e)) ?? []);
  }
}