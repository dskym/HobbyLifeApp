import 'package:dio/dio.dart';
import 'package:hobby_life_app/model/chatroom_model.dart';
import 'package:hobby_life_app/model/common_response_model.dart';
import 'package:hobby_life_app/model/user_model.dart';

class ChatroomRepository {
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:8080',
    connectTimeout: const Duration(seconds: 1).inMilliseconds,
    receiveTimeout: const Duration(seconds: 1).inMilliseconds,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  Future<ChatroomModel> createChatroom({required String name, required String description}) async {
    final response = await _dio.post('/chatroom', data: {
      'name': name,
      'description': description,
    });
    CommonResponseModel<ChatroomModel> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }

  Future<ChatroomModel> deleteChatroom({required int chatroomId}) async {
    final response = await _dio.delete('/chatroom/$chatroomId');
    CommonResponseModel<ChatroomModel> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }

  Future<ChatroomModel> updateChatroom({required int chatroomId, required String name, required String description}) async {
    final response = await _dio.put('/chatroom/$chatroomId', data: {
      'name': name,
      'description': description,
    });
    CommonResponseModel<ChatroomModel> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }

  Future<ChatroomModel> getChatroom({required int chatroomId}) async {
    final response = await _dio.get('/chatroom/$chatroomId');
    CommonResponseModel<ChatroomModel> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }

  Future<List<ChatroomModel>> getAllChatroom() async {
    final response = await _dio.get('/chatroom/all');
    CommonResponseModel<List<ChatroomModel>> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }

  Future<ChatroomModel> joinChatroom({required int chatroomId}) async {
    final response = await _dio.post('/chatroom/$chatroomId');
    CommonResponseModel<ChatroomModel> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }

  Future<List<ChatroomModel>> getJoinChatroom() async {
    final response = await _dio.get('/chatroom/join');
    CommonResponseModel<List<ChatroomModel>> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }

  Future<List<UserModel>> getJoinChatroomUser({required int chatroomId}) async {
    final response = await _dio.get('/chatroom/$chatroomId/user');
    CommonResponseModel<List<UserModel>> commonResponse = CommonResponseModel.fromJson(response.data);
    return commonResponse.data!;
  }
}