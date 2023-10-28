import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hobby_life_app/AppConfig.dart';
import 'package:hobby_life_app/model/common_response_model.dart';
import 'package:hobby_life_app/model/hobby_model.dart';

class HobbyRepository {
  final FlutterSecureStorage _flutterSecureStorage = const FlutterSecureStorage();
  final _dio = Dio(BaseOptions(
    baseUrl: AppConfig.shared.baseUrl,
    connectTimeout: const Duration(seconds: 10).inMilliseconds,
    receiveTimeout: const Duration(seconds: 1).inMilliseconds,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  Future<HobbyModel> createHobby({required int categoryId, required String hobbyName}) async {
    final response = await _dio.post('/hobby', data: {
      'categoryId': categoryId,
      'hobbyName': hobbyName,
    }, options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("createHobby : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return HobbyModel.fromJson(commonResponse.data!);
  }

  Future<void> deleteHobby({required int id}) async {
    await _dio.delete('/hobby/$id', options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("deleteHobby");
  }

  Future<List<HobbyModel>> getHobbyByCategory({required int categoryId}) async {
    final response = await _dio.get('/hobby/$categoryId', options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("getHobbyByCategory : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return List.from(commonResponse.data?.map((e) => HobbyModel.fromJson(e)) ?? []);
  }
}