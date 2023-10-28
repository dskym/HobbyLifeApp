import 'dart:collection';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hobby_life_app/AppConfig.dart';
import 'package:hobby_life_app/model/common_response_model.dart';
import 'package:hobby_life_app/model/hobby_history_model.dart';
import 'package:intl/intl.dart';

class HobbyHistoryRepository {
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

  Future<Map<String, List<HobbyHistoryModel>>> getAllHobbyHistory(DateTime date) async {
    final response = await _dio.get('/hobby/history', queryParameters: {
      'startDate': DateFormat('yyyy-MM-dd').format(DateTime(date.year, date.month, 1)),
      'endDate': DateFormat('yyyy-MM-dd').format(DateTime(date.year, date.month + 1, 0)),
    }, options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));

    print("getAllHobbyHistory : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    LinkedHashMap<String, List<HobbyHistoryModel>> result = LinkedHashMap();
    commonResponse.data!.forEach((key, value) {
      result[key] = List.from(value.map((e) => HobbyHistoryModel.fromJson(e)));
    });
    return result;
  }

  Future<HobbyHistoryModel> addHobbyHistory({required int categoryId, required String name, required String hobbyDate, required String startTime, required String endTime, required String? memo, required int? score, required int? cost}) async {
    final response = await _dio.post('/hobby/history', data: {
      'categoryId': categoryId,
      'name': name,
      'hobbyDate': hobbyDate,
      'startTime': startTime,
      'endTime': endTime,
      'score': score,
      'cost': cost,
      'memo': memo,
    }, options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("addHobbyHistory : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return HobbyHistoryModel.fromJson(commonResponse.data!);
  }

  Future<void> deleteHobbyHistory({required int hobbyHistoryId}) async {
    final response = await _dio.delete('/hobby/history/$hobbyHistoryId', options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("deleteHobbyHistory : ${response.data}");
  }

  Future<HobbyHistoryModel> updateHobbyHistory({required int hobbyHistoryId, required int categoryId, required String name, required String hobbyDate, required String startTime, required String endTime, required String? memo, required int? score, required int? cost}) async {
    final response = await _dio.put('/hobby/history/$hobbyHistoryId', data: {
      'categoryId': categoryId,
      'name': name,
      'hobbyDate': hobbyDate,
      'startTime': startTime,
      'endTime': endTime,
      'score': score,
      'cost': cost,
      'memo': memo,
    }, options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("updateHobbyHistory : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return HobbyHistoryModel.fromJson(commonResponse.data!);
  }

  Future<HobbyHistoryModel> getHobbyHistory({required int hobbyHistoryId}) async {
    final response = await _dio.get('/hobby/history/$hobbyHistoryId', options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("getHobbyHistory : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return HobbyHistoryModel.fromJson(commonResponse.data!);
  }
}