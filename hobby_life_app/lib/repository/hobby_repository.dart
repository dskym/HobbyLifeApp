import 'package:dio/dio.dart';
import 'package:hobby_life_app/model/common_response_model.dart';
import 'package:hobby_life_app/model/hobby_model.dart';

class HobbyRepository {
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:8080',
    connectTimeout: const Duration(seconds: 1).inMilliseconds,
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
    });
    CommonResponseModel<HobbyModel> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }

  Future<HobbyModel> deleteHobby({required int id}) async {
    final response = await _dio.delete('/hobby/$id');
    CommonResponseModel<HobbyModel> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }

  Future<HobbyModel> getHobbyByCategory({required int categoryId}) async {
    final response = await _dio.get('/hobby/$categoryId');
    CommonResponseModel<HobbyModel> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }
}