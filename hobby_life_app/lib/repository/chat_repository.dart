import 'package:dio/dio.dart';
import 'package:hobby_life_app/model/chat_message_model.dart';
import 'package:hobby_life_app/model/common_response_model.dart';

class ChatRepository {
  final _dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8080',
    connectTimeout: const Duration(seconds: 1).inMilliseconds,
    receiveTimeout: const Duration(seconds: 1).inMilliseconds,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyIiwiZXhwIjoxNjk3NzIzNjg4fQ.X3QH5943Mp5eTtqd1HAwY89KSfSS14KvPifSeIaUv0jrF4zYYrCdEvBSOr7W3RLXVLNVpWGbc-VvarIxxn29RQ',
    },
  ));

  Future<List<ChatMessageModel>> getChatMessages(int chatroomId) async {
    final response = await _dio.get('/chatroom/$chatroomId/message');
    print("getChatMessages : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return List.from(commonResponse.data.map((e) => ChatMessageModel.fromJson(e)));
  }
}