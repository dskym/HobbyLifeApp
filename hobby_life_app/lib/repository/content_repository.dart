import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hobby_life_app/model/common_response_model.dart';
import 'package:hobby_life_app/model/content_model.dart';

class ContentRepository {
  final FlutterSecureStorage _flutterSecureStorage = const FlutterSecureStorage();
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8080',
    connectTimeout: const Duration(seconds: 1).inMilliseconds,
    receiveTimeout: const Duration(seconds: 1).inMilliseconds,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

Future<ContentModel> createContent({required int communityId, required String title, required String detail}) async {
    final response = await _dio.post('/community/$communityId/content', data: {
      'title': title,
      'detail': detail,
    }, options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("createContent : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return ContentModel.fromJson(commonResponse.data!);
  }

Future<void> deleteContent({required int communityId, required int contentId}) async {
    final response = await _dio.delete('/community/$communityId/content/$contentId', options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("deleteContent : ${response.data}");
  }

Future<ContentModel> updateContent({required int communityId, required int contentId, required String title, required String detail}) async {
    final response = await _dio.put('/community/$communityId/content/$contentId', data: {
      'title': title,
      'detail': detail,
    }, options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("updateContent : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return ContentModel.fromJson(commonResponse.data!);
  }

Future<ContentModel> getContent({required int communityId, required int contentId}) async {
    final response = await _dio.get('/community/$communityId/content/$contentId', options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("getContent : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return ContentModel.fromJson(commonResponse.data!);
  }

Future<List<ContentModel>> getAllContent({required int communityId}) async {
    final response = await _dio.get('/community/$communityId/content', options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("getAllContent : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return List.from(commonResponse.data?.map((e) => ContentModel.fromJson(e)) ?? []);
  }
}