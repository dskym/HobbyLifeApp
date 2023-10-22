import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hobby_life_app/model/category_model.dart';
import 'package:hobby_life_app/model/common_response_model.dart';

class CategoryRepository {
  final FlutterSecureStorage _flutterSecureStorage = const FlutterSecureStorage();
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8080',
    connectTimeout: const Duration(seconds: 1).inMilliseconds,
    receiveTimeout: const Duration(seconds: 1).inMilliseconds,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  Future<List<CategoryModel>> getAllCategory() async {
    final response = await _dio.get('/category', options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("getAllCategory : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return List.from(commonResponse.data?.map((e) => CategoryModel.fromJson(e)) ?? []);
  }

  Future<CategoryModel> createCategory({required String categoryName}) async {
    final response = await _dio.post('/category', data: {
      'categoryName': categoryName,
    }, options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("createCategory : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return CategoryModel.fromJson(commonResponse.data!);
  }

  Future<CategoryModel> deleteCategory({required int id}) async {
    final response = await _dio.delete('/category/$id', options: Options(headers: {
      HttpHeaders.authorizationHeader: await _flutterSecureStorage.read(key: 'accessToken'),
    }));
    print("deleteCategory : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return CategoryModel.fromJson(commonResponse.data!);
  }
}