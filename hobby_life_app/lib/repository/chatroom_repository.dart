import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hobby_life_app/AppConfig.dart';
import 'package:hobby_life_app/model/chatroom_model.dart';
import 'package:hobby_life_app/model/common_response_model.dart';
import 'package:hobby_life_app/model/user_model.dart';

class ChatroomRepository {
  final FlutterSecureStorage _flutterSecureStorage = const FlutterSecureStorage();
  final _dio = Dio(BaseOptions(
    baseUrl: AppConfig.shared.baseUrl,
    connectTimeout: const Duration(seconds: 10).inMilliseconds,
    receiveTimeout: const Duration(seconds: 1).inMilliseconds,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyIiwiZXhwIjoxNjk4MDQzOTg1fQ.WcOUu29GimufWaaKmlnlnuTudHLPm3FU8gISNDd6S5I3FX-8iLeXycTe1Wob1dR2gUTQAGsnf6s0zgakSZprEA',
    },
  ));

  Future<ChatroomModel> createChatroom({required String name, required String description}) async {
    final response = await _dio.post('/chatroom', data: {
      'name': name,
      'description': description,
    }, options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("createChatroom : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return ChatroomModel.fromJson(commonResponse.data!);
  }

  Future<ChatroomModel> deleteChatroom({required int chatroomId}) async {
    final response = await _dio.delete('/chatroom/$chatroomId', options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("deleteChatroom : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return ChatroomModel.fromJson(commonResponse.data!);
  }

  Future<ChatroomModel> updateChatroom({required int chatroomId, required String name, required String description}) async {
    final response = await _dio.put('/chatroom/$chatroomId', data: {
      'name': name,
      'description': description,
    }, options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("updateChatroom : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return ChatroomModel.fromJson(commonResponse.data!);
  }

  Future<ChatroomModel> getChatroom({required int chatroomId}) async {
    final response = await _dio.get('/chatroom/$chatroomId', options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("getChatroom : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return ChatroomModel.fromJson(commonResponse.data!);
  }

  Future<List<ChatroomModel>> getAllChatroom() async {
    final response = await _dio.get('/chatroom/all', options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("getAllChatroom : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return List.from(commonResponse.data?.map((e) => ChatroomModel.fromJson(e)) ?? []);
  }

  Future<void> joinChatroom({required int chatroomId}) async {
    final response = await _dio.post('/chatroom/$chatroomId/join', options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("joinChatroom : ${response.data}");
  }

  Future<void> leaveChatroom({required int chatroomId}) async {
    final response = await _dio.delete('/chatroom/$chatroomId/leave', options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("leaveChatroom");
  }

  Future<List<ChatroomModel>> getJoinChatroom() async {
    final response = await _dio.get('/chatroom/join', options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("getJoinChatroom : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return List.from(commonResponse.data?.map((e) => ChatroomModel.fromJson(e)) ?? []);
  }

  Future<List<UserModel>> getJoinChatroomUser({required int chatroomId}) async {
    final response = await _dio.get('/chatroom/$chatroomId/user', options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("getJoinChatroomUser : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return List.from(commonResponse.data?.map((e) => UserModel.fromJson(e)) ?? []);
  }
}