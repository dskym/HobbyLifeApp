import 'package:hobby_life_app/model/chat_message_model.dart';
import 'package:hobby_life_app/repository/chat_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_provider.g.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) => ChatRepository());


@riverpod
class Chat extends _$Chat {
  @override
  Future<List<ChatMessageModel>> build(int chatroomId) async {
    return ref.read(chatRepositoryProvider).getChatMessages(chatroomId);
  }

  Future<void> addMessage(ChatMessageModel chatMessageModel) async {
    final previousState = await future;
    state = AsyncData([...previousState, chatMessageModel]);
  }
}