import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hobby_life_app/component/chatroom_card.dart';
import 'package:hobby_life_app/provider/chatroom_provider.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatroomList = ref.watch(chatroomListProvider);

    return chatroomList.when(
        data: (chatroomList) => ListView.builder(
          itemCount: chatroomList.length,
          itemBuilder: (BuildContext context, int index) {
            return ChatroomCard(
              name: chatroomList[index].name,
              description: chatroomList[index].description,
              lastMessageTime: DateTime.now(),
            );
          },
        ),
        error: (error, stackTrace) {
          return const Center(child: Text('Error'));
        },
        loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}