import 'package:dio/dio.dart';
import 'package:hobby_life_app/model/common_response_model.dart';
import 'package:hobby_life_app/model/hobby_history_model.dart';

class HobbyHistoryRepository {
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:8080',
    connectTimeout: const Duration(seconds: 1).inMilliseconds,
    receiveTimeout: const Duration(seconds: 1).inMilliseconds,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  Future<List<HobbyHistoryModel>> getAllHobbyHistory() async {
    final response = await _dio.get('/hobby/history');
    CommonResponseModel<List<HobbyHistoryModel>> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }

  Future<HobbyHistoryModel> addHobbyHistory({required int hobbyId, required int score, required int cost, required DateTime hobbyDate}) async {
    final response = await _dio.post('/hobby/history', data: {
      'hobbyId': hobbyId,
      'score': score,
      'cost': cost,
      'hobbyDate': hobbyDate,
    });
    CommonResponseModel<HobbyHistoryModel> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }

  Future<HobbyHistoryModel> deleteHobbyHistory({required int hobbyHistoryId}) async {
    final response = await _dio.delete('/hobby/history/$hobbyHistoryId');
    CommonResponseModel<HobbyHistoryModel> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }

  Future<HobbyHistoryModel> updateHobbyHistory({required int hobbyHistoryId, required int hobbyId, required int score, required int cost, required DateTime hobbyDate}) async {
    final response = await _dio.put('/hobby/history/$hobbyHistoryId', data: {
      'hobbyId': hobbyId,
      'score': score,
      'cost': cost,
      'hobbyDate': hobbyDate,
    });
    CommonResponseModel<HobbyHistoryModel> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }

  Future<HobbyHistoryModel> getHobbyHistory({required int hobbyHistoryId}) async {
    final response = await _dio.get('/hobby/history/$hobbyHistoryId');
    CommonResponseModel<HobbyHistoryModel> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }
}