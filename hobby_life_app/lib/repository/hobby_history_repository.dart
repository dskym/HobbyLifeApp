import 'package:dio/dio.dart';
import 'package:hobby_life_app/model/common_response_model.dart';
import 'package:hobby_life_app/model/hobby_history_model.dart';

class HobbyHistoryRepository {
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8080',
    connectTimeout: const Duration(seconds: 1).inMilliseconds,
    receiveTimeout: const Duration(seconds: 1).inMilliseconds,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyOSIsImV4cCI6MTY5NzIxNjgzMH0.Bg2R5wfY7izCl61hiXlKExZGRDOhCAmL7doOlTGvDjqIsPg0SRhLjwPGY-d1uDjoeI5A0KMoYsx_J31vIkwqMA',
    },
  ));

  Future<List<HobbyHistoryModel>> getAllHobbyHistory() async {
    final response = await _dio.get('/hobby/history');
    print("getAllHobbyHistory : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return List.from(commonResponse.data?.map((e) => HobbyHistoryModel.fromJson(e)) ?? []);
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