import 'package:dio/dio.dart';
import 'package:hobby_life_app/model/common_response_model.dart';
import 'package:hobby_life_app/model/user_auth_model.dart';

class UserRepository {
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:8080',
    connectTimeout: const Duration(seconds: 1).inMilliseconds,
    receiveTimeout: const Duration(seconds: 1).inMilliseconds,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  Future<UserAuthModel> registerUser({required String email, required String password, required String name}) async {
    final response = await _dio.post('/user', data: {
      'email': email,
      'password': password,
      'name': name,
    });
    CommonResponseModel<UserAuthModel> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }

  Future<UserAuthModel> leaveUser() async {
    final response = await _dio.delete('/user');
    CommonResponseModel<UserAuthModel> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }

}