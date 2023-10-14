import 'package:dio/dio.dart';
import 'package:hobby_life_app/model/common_response_model.dart';
import 'package:hobby_life_app/model/user_auth_model.dart';

class UserAuthRepository {
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8080',
    connectTimeout: const Duration(seconds: 1).inMilliseconds,
    receiveTimeout: const Duration(seconds: 1).inMilliseconds,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyIiwiZXhwIjoxNjk3MzUxNDM3fQ.TCkhPqFy9V5KwWUV_knZK52d-eW3i1ifgiHpRQDPU6G7A2t3ZUXexU9-6m9fK8ZMkcy1gl03FDleJ7m0mPH1_Q',
    },
  ));

  Future<UserAuthModel> login({required String email, required String password}) async {
    final response = await _dio.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
    print("login : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return UserAuthModel.fromJson(commonResponse.data!);
  }
}