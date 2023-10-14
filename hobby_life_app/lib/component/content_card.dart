import 'package:flutter/material.dart';
import 'package:hobby_life_app/screen/content_detail_screen.dart';

class ContentCard extends StatelessWidget {
  final String title;
  final String detail;
  final String authorName;

  const ContentCard(
      {Key? key,
      required this.title,
      required this.detail,
      required this.authorName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.content_copy),
        title: Text(title),
        subtitle: Text(detail),
        trailing: Text(authorName),
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
              pageBuilder: (context, animation, secondaryAnimation) {
                return ContentDetailScreen();
              },
            ),
          );
        },
      ),
    );
  }
}