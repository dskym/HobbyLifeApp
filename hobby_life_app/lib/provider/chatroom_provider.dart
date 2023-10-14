import 'package:hobby_life_app/model/chatroom_model.dart';
import 'package:hobby_life_app/model/user_model.dart';
import 'package:hobby_life_app/repository/chatroom_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chatroom_provider.g.dart';

final chatroomRepositoryProvider = Provider<ChatroomRepository>((ref) => ChatroomRepository());

@riverpod
class Chatroom extends _$Chatroom {
  @override
  Future<ChatroomModel> build(int chatroomId) async {
    return ref.read(chatroomRepositoryProvider).getChatroom(chatroomId: chatroomId);
  }
}


@riverpod
class ChatroomMemberList extends _$ChatroomMemberList {
  @override
  Future<List<UserModel>> build(int chatroomId) async {
    return ref.read(chatroomRepositoryProvider).getJoinChatroomUser(chatroomId: chatroomId);
  }
}

@riverpod
class ChatroomList extends _$ChatroomList {
  @override
  Future<List<ChatroomModel>> build() async {
    return ref.read(chatroomRepositoryProvider).getAllChatroom();
  }

  Future<void> createChatroom({required String name, required String description}) async {
    final chatroomRepository = ref.read(chatroomRepositoryProvider);
    final chatroomModel = await chatroomRepository.createChatroom(name: name, description: description);
    final previousState = await future;
    state = AsyncData([...previousState, chatroomModel]);
  }

  Future<void> deleteChatroom({required int id}) async {
    final chatroomRepository = ref.read(chatroomRepositoryProvider);
    await chatroomRepository.deleteChatroom(chatroomId: id);
    final previousState = await future;
    state = AsyncData(previousState.where((element) => element.chatroomId != id).toList());
  }

  Future<void> updateChatroom({required int id, required String name, required String description}) async {
    final chatroomRepository = ref.read(chatroomRepositoryProvider);
    await chatroomRepository.updateChatroom(chatroomId: id, name: name, description: description);
    final previousState = await future;
    state = AsyncData(previousState.map((element) {
      if (element.chatroomId == id) {
        return element.copyWith(name: name, description: description);
      }
      return element;
    }).toList());
  }

  Future<void> joinChatroom({required int id}) async {
    final chatroomRepository = ref.read(chatroomRepositoryProvider);
    final chatroomModel = await chatroomRepository.joinChatroom(chatroomId: id);
    final previousState = await future;
    state = AsyncData([...previousState, chatroomModel]);
  }

  Future<void> getAllChatroom() async {
    final chatroomRepository = ref.read(chatroomRepositoryProvider);
    final chatroomModel = await chatroomRepository.getAllChatroom();
    state = AsyncData(chatroomModel);
  }

  Future<void> getJoinChatroom() async {
    final chatroomRepository = ref.read(chatroomRepositoryProvider);
    final chatroomModel = await chatroomRepository.getJoinChatroom();
    state = AsyncData(chatroomModel);
  }
}
