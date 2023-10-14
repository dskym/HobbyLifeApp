import 'package:dio/dio.dart';
import 'package:hobby_life_app/model/chatroom_model.dart';
import 'package:hobby_life_app/model/common_response_model.dart';
import 'package:hobby_life_app/model/user_model.dart';

class ChatroomRepository {
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8080',
    connectTimeout: const Duration(seconds: 1).inMilliseconds,
    receiveTimeout: const Duration(seconds: 1).inMilliseconds,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyIiwiZXhwIjoxNjk3MzUxNDM3fQ.TCkhPqFy9V5KwWUV_knZK52d-eW3i1ifgiHpRQDPU6G7A2t3ZUXexU9-6m9fK8ZMkcy1gl03FDleJ7m0mPH1_Q',
    },
  ));

  Future<ChatroomModel> createChatroom({required String name, required String description}) async {
    final response = await _dio.post('/chatroom', data: {
      'name': name,
      'description': description,
    });
    print("createChatroom : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return ChatroomModel.fromJson(commonResponse.data!);
  }

  Future<ChatroomModel> deleteChatroom({required int chatroomId}) async {
    final response = await _dio.delete('/chatroom/$chatroomId');
    print("deleteChatroom : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return ChatroomModel.fromJson(commonResponse.data!);
  }

  Future<ChatroomModel> updateChatroom({required int chatroomId, required String name, required String description}) async {
    final response = await _dio.put('/chatroom/$chatroomId', data: {
      'name': name,
      'description': description,
    });
    print("updateChatroom : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return ChatroomModel.fromJson(commonResponse.data!);
  }

  Future<ChatroomModel> getChatroom({required int chatroomId}) async {
    final response = await _dio.get('/chatroom/$chatroomId');
    print("getChatroom : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return ChatroomModel.fromJson(commonResponse.data!);
  }

  Future<List<ChatroomModel>> getAllChatroom() async {
    final response = await _dio.get('/chatroom/all');
    print("getAllChatroom : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return List.from(commonResponse.data?.map((e) => ChatroomModel.fromJson(e)) ?? []);
  }

  Future<ChatroomModel> joinChatroom({required int chatroomId}) async {
    final response = await _dio.post('/chatroom/$chatroomId');
    print("joinChatroom : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return ChatroomModel.fromJson(commonResponse.data!);
  }

  Future<List<ChatroomModel>> getJoinChatroom() async {
    final response = await _dio.get('/chatroom/join');
    print("getJoinChatroom : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return List.from(commonResponse.data?.map((e) => ChatroomModel.fromJson(e)) ?? []);
  }

  Future<List<UserModel>> getJoinChatroomUser({required int chatroomId}) async {
    final response = await _dio.get('/chatroom/$chatroomId/user');
    print("getJoinChatroomUser : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return List.from(commonResponse.data?.map((e) => UserModel.fromJson(e)) ?? []);
  }
}