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
      'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxIiwiZXhwIjoxNjk3MzA5MzUwfQ.e-Huq6mP1Jw4RXL0jQVd3LEiz1QL7NC5VFFFZ75LZygk48Ici1phNkuFZ8g1gyXhK-jtBD1t9lzaXX0kJF3p6Q',
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