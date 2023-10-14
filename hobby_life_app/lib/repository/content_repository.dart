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
      'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxIiwiZXhwIjoxNjk3MzA5MzUwfQ.e-Huq6mP1Jw4RXL0jQVd3LEiz1QL7NC5VFFFZ75LZygk48Ici1phNkuFZ8g1gyXhK-jtBD1t9lzaXX0kJF3p6Q',
    },
  ));

Future<ContentModel> createContent({required String communityId, required String title, required String detail}) async {
    final response = await _dio.post('/community/$communityId/content', data: {
      'title': title,
      'detail': detail,
    });
    print("createContent : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return ContentModel.fromJson(commonResponse.data!);
  }

Future<ContentModel> deleteContent({required String communityId, required String contentId}) async {
    final response = await _dio.delete('/community/$communityId/content/$contentId');
    print("deleteContent : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return ContentModel.fromJson(commonResponse.data!);
  }

Future<ContentModel> updateContent({required String communityId, required String contentId, required String title, required String detail}) async {
    final response = await _dio.put('/community/$communityId/content/$contentId', data: {
      'title': title,
      'detail': detail,
    });
    print("updateContent : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return ContentModel.fromJson(commonResponse.data!);
  }

Future<ContentModel> getContent({required String communityId, required String contentId}) async {
    final response = await _dio.get('/community/$communityId/content/$contentId');
    print("getContent : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return ContentModel.fromJson(commonResponse.data!);
  }

Future<List<ContentModel>> getAllContent({required String communityId}) async {
    final response = await _dio.get('/community/$communityId/content');
    print("getAllContent : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return List.from(commonResponse.data?.map((e) => ContentModel.fromJson(e)) ?? []);
  }
}