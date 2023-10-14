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
      'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxIiwiZXhwIjoxNjk3MzA5MzUwfQ.e-Huq6mP1Jw4RXL0jQVd3LEiz1QL7NC5VFFFZ75LZygk48Ici1phNkuFZ8g1gyXhK-jtBD1t9lzaXX0kJF3p6Q',
    },
  ));

  Future<Map<String, List<HobbyHistoryModel>>> getAllHobbyHistory(DateTime now) async {
    final response = await _dio.get('/hobby/history', queryParameters: {
      'startDate': DateFormat('yyyy-MM-dd').format(DateTime(now.year, now.month, 1)),
      'endDate': DateFormat('yyyy-MM-dd').format(DateTime(now.year, now.month + 1, 0)),
    });

    print("getAllHobbyHistory : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    LinkedHashMap<String, List<HobbyHistoryModel>> result = LinkedHashMap();
    commonResponse.data!.forEach((key, value) {
      result[key] = List.from(value.map((e) => HobbyHistoryModel.fromJson(e)));
    });
    return result;
  }

  Future<HobbyHistoryModel> addHobbyHistory({required int hobbyId, required int score, required int cost, required DateTime hobbyDate}) async {
    final response = await _dio.post('/hobby/history', data: {
      'hobbyId': hobbyId,
      'score': score,
      'cost': cost,
      'hobbyDate': hobbyDate,
    });
    print("addHobbyHistory : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return HobbyHistoryModel.fromJson(commonResponse.data!);
  }

  Future<HobbyHistoryModel> deleteHobbyHistory({required int hobbyHistoryId}) async {
    final response = await _dio.delete('/hobby/history/$hobbyHistoryId');
    print("deleteHobbyHistory : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return HobbyHistoryModel.fromJson(commonResponse.data!);
  }

  Future<HobbyHistoryModel> updateHobbyHistory({required int hobbyHistoryId, required int hobbyId, required int score, required int cost, required DateTime hobbyDate}) async {
    final response = await _dio.put('/hobby/history/$hobbyHistoryId', data: {
      'hobbyId': hobbyId,
      'score': score,
      'cost': cost,
      'hobbyDate': hobbyDate,
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