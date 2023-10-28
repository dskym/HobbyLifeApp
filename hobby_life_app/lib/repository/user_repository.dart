import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hobby_life_app/AppConfig.dart';
import 'package:hobby_life_app/model/common_response_model.dart';
import 'package:hobby_life_app/model/user_auth_model.dart';
import 'package:hobby_life_app/model/user_model.dart';

class UserRepository {
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

  Future<UserModel> getUser() async {
    final response = await _dio.get('/user', options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("getUser : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return UserModel.fromJson(commonResponse.data!);
  }

  Future<UserAuthModel> registerUser({required String email, required String password, required String name}) async {
    final response = await _dio.post('/user', data: {
      'email': email,
      'password': password,
      'name': name,
    });
    print("registerUser : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return UserAuthModel.fromJson(commonResponse.data!);
  }

  Future<void> leaveUser() async {
    final response = await _dio.delete('/user', options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("leaveUser : ${response.data}");
  }
}