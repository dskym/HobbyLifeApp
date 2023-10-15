import 'package:dio/dio.dart';
import 'package:hobby_life_app/model/chat_message_model.dart';
import 'package:hobby_life_app/model/common_response_model.dart';

class ChatRepository {
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

  Future<List<ChatMessageModel>> getChatMessages(int chatroomId) async {
    final response = await _dio.get('/chatroom/$chatroomId/message');
    print("getChatMessages : ${response.data}");
    CommonResponseModel<dynamic> commonResponse = CommonResponseModel.fromJson(response.data);
    return List.from(commonResponse.data.map((e) => ChatMessageModel.fromJson(e)));
  }
}