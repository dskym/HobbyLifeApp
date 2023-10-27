import 'package:flutter/material.dart';
import 'package:hobby_life_app/screen/chatroom_screen.dart';

class ChatroomCard extends StatelessWidget {
  final int chatroomId;
  final String name;
  final String description;
  final String? lastMessage;
  final DateTime? lastMessageTime;
  final bool isJoin;

  const ChatroomCard(
      {Key? key,
      required this.chatroomId,
      required this.name,
      required this.description,
      required this.lastMessage,
      required this.lastMessageTime,
      required this.isJoin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.chat),
        title: Text(name),
        subtitle: Text(lastMessage ?? ''),
        trailing: Text(lastMessageTime.toString()),
        onTap: () {
          // if(isJoin == false) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(
          //       content: Text('채팅방에 가입해야 이용할 수 있습니다.'),
          //     ),
          //   );
          //   return;
          // }

          Navigator.push(
            context,
            PageRouteBuilder(
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                var begin = const Offset(0.0, 1.0);
                var end = Offset.zero;
                var curve = Curves.ease;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
              transitionDuration: const Duration(milliseconds: 100),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  ChatroomScreen(
                id: chatroomId,
                name: name,
              ),
            ),
          );
        },
      ),
    );
  }
}
