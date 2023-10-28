import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hobby_life_app/provider/chatroom_provider.dart';
import 'package:hobby_life_app/screen/chatroom_screen.dart';

class ChatroomCard extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.chat),
        title: Text(name),
        subtitle: Text(isJoin ? description ?? '' : '채팅방에 가입해야 볼 수 있는 메시지 입니다.'),
        trailing: Text(isJoin ? lastMessageTime?.toString() ?? '' : ''),
        onTap: () {
          if(isJoin == false) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('채팅방 가입'),
                  content: const Text('채팅방에 가입하시겠습니까?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('취소'),
                    ),
                    TextButton(
                      onPressed: () {
                        ref.read(chatroomProvider(chatroomId).notifier).joinChatroom(chatroomId: chatroomId);
                        Navigator.pop(context);
                      },
                      child: const Text('가입'),
                    ),
                  ],
                );
              },
            );
            return;
          }
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
