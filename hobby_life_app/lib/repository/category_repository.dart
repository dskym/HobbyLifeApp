import 'package:dio/dio.dart';
import 'package:hobby_life_app/model/category_model.dart';
import 'package:hobby_life_app/model/common_response_model.dart';

class CategoryRepository {
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

  Future<List<CategoryModel>> getAllCategory() async {
    final response = await _dio.get('/category');
    print("getAllCategory : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return List.from(commonResponse.data?.map((e) => CategoryModel.fromJson(e)) ?? []);
  }

  Future<CategoryModel> createCategory({required String categoryName}) async {
    final response = await _dio.post('/category', data: {
      'categoryName': categoryName,
    });
    print("createCategory : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return CategoryModel.fromJson(commonResponse.data!);
  }

  Future<CategoryModel> deleteCategory({required int id}) async {
    final response = await _dio.delete('/category/$id');
    print("deleteCategory : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return CategoryModel.fromJson(commonResponse.data!);
  }
}