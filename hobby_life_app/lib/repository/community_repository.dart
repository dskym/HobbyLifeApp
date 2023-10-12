import 'package:dio/dio.dart';
import 'package:hobby_life_app/model/common_response_model.dart';
import 'package:hobby_life_app/model/community_model.dart';

class CommunityRepository {
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:8080',
    connectTimeout: const Duration(seconds: 1).inMilliseconds,
    receiveTimeout: const Duration(seconds: 1).inMilliseconds,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  Future<CommunityModel> createCommunity({required String title, required String description, required int hobbyId}) async {
    final response = await _dio.post('/community', data: {
      'title': title,
      'description': description,
      'hobbyId': hobbyId,
    });
    CommonResponseModel<CommunityModel> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }

  Future<CommunityModel> deleteCommunity({required String communityId}) async {
    final response = await _dio.delete('/community/$communityId');
    CommonResponseModel<CommunityModel> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }

  Future<CommunityModel> updateCommunity({required String communityId, required String title, required String description, required int hobbyId}) async {
    final response = await _dio.put('/community/$communityId', data: {
      'title': title,
      'description': description,
      'hobbyId': hobbyId,
    });
    CommonResponseModel<CommunityModel> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }

  Future<CommunityModel> getCommunity({required String communityId}) async {
    final response = await _dio.get('/community/$communityId');
    CommonResponseModel<CommunityModel> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }

  Future<List<CommunityModel>> getAllCommunity() async {
    final response = await _dio.get('/community');
    CommonResponseModel<List<CommunityModel>> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }

  Future<CommunityModel> joinCommunity({required String communityId}) async {
    final response = await _dio.post('/community/$communityId/join');
    CommonResponseModel<CommunityModel> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }

  Future<CommunityModel> leaveCommunity({required String communityId}) async {
    final response = await _dio.delete('/community/$communityId/leave');
    CommonResponseModel<CommunityModel> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }

  Future<List<CommunityModel>> getJoinCommunity() async {
    final response = await _dio.get('/community/join');
    CommonResponseModel<List<CommunityModel>> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }
}