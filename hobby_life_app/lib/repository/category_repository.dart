import 'package:dio/dio.dart';
import 'package:hobby_life_app/model/category_model.dart';
import 'package:hobby_life_app/model/common_response_model.dart';

class CategoryRepository {
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:8080',
    connectTimeout: const Duration(seconds: 1).inMilliseconds,
    receiveTimeout: const Duration(seconds: 1).inMilliseconds,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  Future<List<CategoryModel>> getAllCategory() async {
    final response = await _dio.get('/category');
    CommonResponseModel<List<CategoryModel>> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }

  Future<CategoryModel> createCategory({required String categoryName}) async {
    final response = await _dio.post('/category', data: {
      'categoryName': categoryName,
    });
    CommonResponseModel<CategoryModel> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }

  Future<CategoryModel> deleteCategory({required int id}) async {
    final response = await _dio.delete('/category/$id');
    CommonResponseModel<CategoryModel> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }
}