import 'package:flutter/material.dart';
import 'package:hobby_life_app/component/chatroom_card.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final List<String> entries = <String>['A', 'B', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return ChatroomCard(
          name: "채팅방 ${entries[index]}",
          description: "채팅방 ${entries[index]} 설명",
          lastMessageTime: DateTime.now(),
        );
      },
    );
  }
}