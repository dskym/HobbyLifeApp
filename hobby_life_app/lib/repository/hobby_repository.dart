import 'package:dio/dio.dart';
import 'package:hobby_life_app/model/common_response_model.dart';
import 'package:hobby_life_app/model/hobby_model.dart';

class HobbyRepository {
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

  Future<HobbyModel> createHobby({required int categoryId, required String hobbyName}) async {
    final response = await _dio.post('/hobby', data: {
      'categoryId': categoryId,
      'hobbyName': hobbyName,
    });
    print("createHobby : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return HobbyModel.fromJson(commonResponse.data!);
  }

  Future<void> deleteHobby({required int id}) async {
    await _dio.delete('/hobby/$id');
    print("deleteHobby");
  }

  Future<List<HobbyModel>> getHobbyByCategory({required int categoryId}) async {
    final response = await _dio.get('/hobby/$categoryId');
    print("getHobbyByCategory : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return List.from(commonResponse.data?.map((e) => HobbyModel.fromJson(e)) ?? []);
  }
}