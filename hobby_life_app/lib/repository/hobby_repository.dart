import 'package:dio/dio.dart';
import 'package:hobby_life_app/model/common_response_model.dart';
import 'package:hobby_life_app/model/hobby_model.dart';

class HobbyRepository {
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://172.30.1.17:8080',
    connectTimeout: const Duration(seconds: 1).inMilliseconds,
    receiveTimeout: const Duration(seconds: 1).inMilliseconds,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyIiwiZXhwIjoxNjk3NDM4NzU4fQ.KaQTyehMvZx-0ep8MkMjonObcBkBorKA0kOnLrsyubKM9OXoqqlYYX-vH65b-fUt8CIqAyXprEudWJLHUrBY9g',
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