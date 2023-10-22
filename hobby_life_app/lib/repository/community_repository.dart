import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hobby_life_app/model/common_response_model.dart';
import 'package:hobby_life_app/model/community_model.dart';
import 'package:hobby_life_app/model/user_model.dart';

class CommunityRepository {
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

  Future<CommunityModel> createCommunity({required String title, required String description, required int categoryId}) async {
    final response = await _dio.post('/community', data: {
      'title': title,
      'description': description,
      'categoryId': categoryId,
    }, options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("createCommunity : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return CommunityModel.fromJson(commonResponse.data!);
  }

  Future<void> deleteCommunity({required int communityId}) async {
    final response = await _dio.delete('/community/$communityId', options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("deleteCommunity : ${response.data}");
  }

  Future<CommunityModel> updateCommunity({required int communityId, required String title, required String description, required int categoryId}) async {
    final response = await _dio.put('/community/$communityId', data: {
      'title': title,
      'description': description,
      'categoryId': categoryId,
    }, options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("updateCommunity : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return CommunityModel.fromJson(commonResponse.data!);
  }

  Future<CommunityModel> getCommunity({required int communityId}) async {
    final response = await _dio.get('/community/$communityId', options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("getCommunity : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return CommunityModel.fromJson(commonResponse.data!);
  }

  Future<List<CommunityModel>> getAllCommunity() async {
    final response = await _dio.get('/community', options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("getAllCommunity : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return List.from(commonResponse.data?.map((e) => CommunityModel.fromJson(e)) ?? []);
  }

  Future<void> joinCommunity({required int communityId}) async {
    final response = await _dio.post('/community/$communityId/join', options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("joinCommunity : ${response.data}");
  }

  Future<void> leaveCommunity({required int communityId}) async {
    await _dio.delete('/community/$communityId/leave', options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("leaveCommunity");
  }

  Future<List<CommunityModel>> getJoinCommunity() async {
    final response = await _dio.get('/community/join', options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("getJoinCommunity : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return List.from(commonResponse.data?.map((e) => CommunityModel.fromJson(e)) ?? []);
  }

  Future<List<UserModel>> getJoinCommunityMember({required int communityId}) async {
    final response = await _dio.get('/community/$communityId/member', options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("getJoinCommunityMember : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return List.from(commonResponse.data?.map((e) => UserModel.fromJson(e)) ?? []);
  }
}