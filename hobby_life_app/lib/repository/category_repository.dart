import 'package:dio/dio.dart';
import 'package:hobby_life_app/model/category_model.dart';
import 'package:hobby_life_app/model/common_response_model.dart';

class CategoryRepository {
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