import 'package:dio/dio.dart';
import 'package:hobby_life_app/model/common_response_model.dart';
import 'package:hobby_life_app/model/community_model.dart';

class CommunityRepository {
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8080',
    connectTimeout: const Duration(seconds: 1).inMilliseconds,
    receiveTimeout: const Duration(seconds: 1).inMilliseconds,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyIiwiZXhwIjoxNjk4MDQzOTg1fQ.WcOUu29GimufWaaKmlnlnuTudHLPm3FU8gISNDd6S5I3FX-8iLeXycTe1Wob1dR2gUTQAGsnf6s0zgakSZprEA',
    },
  ));

  Future<CommunityModel> createCommunity({required String title, required String description, required int categoryId}) async {
    final response = await _dio.post('/community', data: {
      'title': title,
      'description': description,
      'categoryId': categoryId,
    });
    print("createCommunity : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return CommunityModel.fromJson(commonResponse.data!);
  }

  Future<void> deleteCommunity({required int communityId}) async {
    final response = await _dio.delete('/community/$communityId');
    print("deleteCommunity : ${response.data}");
  }

  Future<CommunityModel> updateCommunity({required int communityId, required String title, required String description, required int categoryId}) async {
    final response = await _dio.put('/community/$communityId', data: {
      'title': title,
      'description': description,
      'categoryId': categoryId,
    });
    print("updateCommunity : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return CommunityModel.fromJson(commonResponse.data!);
  }

  Future<CommunityModel> getCommunity({required int communityId}) async {
    final response = await _dio.get('/community/$communityId');
    print("getCommunity : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return CommunityModel.fromJson(commonResponse.data!);
  }

  Future<List<CommunityModel>> getAllCommunity() async {
    final response = await _dio.get('/community');
    print("getAllCommunity : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return List.from(commonResponse.data?.map((e) => CommunityModel.fromJson(e)) ?? []);
  }

  Future<void> joinCommunity({required int communityId}) async {
    final response = await _dio.post('/community/$communityId/join');
    print("joinCommunity : ${response.data}");
  }

  Future<void> leaveCommunity({required int communityId}) async {
    await _dio.delete('/community/$communityId/leave');
    print("leaveCommunity");
  }

  Future<List<CommunityModel>> getJoinCommunity() async {
    final response = await _dio.get('/community/join');
    print("getJoinCommunity : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return List.from(commonResponse.data?.map((e) => CommunityModel.fromJson(e)) ?? []);
  }
}