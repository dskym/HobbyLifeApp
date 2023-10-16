import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:hobby_life_app/model/common_response_model.dart';
import 'package:hobby_life_app/model/hobby_history_model.dart';
import 'package:intl/intl.dart';

class HobbyHistoryRepository {
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8080',
    connectTimeout: const Duration(seconds: 1).inMilliseconds,
    receiveTimeout: const Duration(seconds: 1).inMilliseconds,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyIiwiZXhwIjoxNjk3NjMwNDkzfQ.SIzguL_EnaWrHzrNe6wwZQjnOk7GBFMFbIYVLrvZ1_ZwPHHJketMDO1wKVdDmkZFYBuKSraEHVVr5zC9v7ZBYQ',
    },
  ));

  Future<Map<String, List<HobbyHistoryModel>>> getAllHobbyHistory(DateTime date) async {
    final response = await _dio.get('/hobby/history', queryParameters: {
      'startDate': DateFormat('yyyy-MM-dd').format(DateTime(date.year, date.month, 1)),
      'endDate': DateFormat('yyyy-MM-dd').format(DateTime(date.year, date.month + 1, 0)),
    });

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
    });
    print("addHobbyHistory : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return HobbyHistoryModel.fromJson(commonResponse.data!);
  }

  Future<void> deleteHobbyHistory({required int hobbyHistoryId}) async {
    final response = await _dio.delete('/hobby/history/$hobbyHistoryId');
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
    });
    print("updateHobbyHistory : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return HobbyHistoryModel.fromJson(commonResponse.data!);
  }

  Future<HobbyHistoryModel> getHobbyHistory({required int hobbyHistoryId}) async {
    final response = await _dio.get('/hobby/history/$hobbyHistoryId');
    print("getHobbyHistory : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return HobbyHistoryModel.fromJson(commonResponse.data!);
  }
}