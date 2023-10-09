import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class ChatMessage extends StatelessWidget {
  final String message;
  final String name;
  final DateTime time;
  final bool isMe;

  const ChatMessage({Key? key, required this.message, required this.name, required this.isMe, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
        ),
        ChatBubble(
          clipper: ChatBubbleClipper5(type: isMe ? BubbleType.sendBubble : BubbleType.receiverBubble),
          alignment: isMe ? Alignment.topRight : Alignment.topLeft,
          margin: const EdgeInsets.only(top: 20),
          backGroundColor: isMe ? Colors.blue : Colors.grey[300],
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 200,
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        Align(
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Text(
            time.toString(),
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}