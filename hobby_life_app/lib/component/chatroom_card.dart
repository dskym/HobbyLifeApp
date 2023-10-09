import 'package:flutter/material.dart';
import 'package:hobby_life_app/screen/chatroom_screen.dart';

class ChatroomCard extends StatelessWidget {
  final String name;
  final String description;
  final DateTime lastMessageTime;

  const ChatroomCard(
      {Key? key,
      required this.name,
      required this.description,
      required this.lastMessageTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.chat),
        title: Text(name),
        subtitle: Text(description),
        trailing: Text(lastMessageTime.toString()),
        onTap: () {
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
                name: name,
              ),
            ),
          );
        },
      ),
    );
  }
}
