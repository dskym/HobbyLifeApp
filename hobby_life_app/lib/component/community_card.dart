import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hobby_life_app/screen/community_detail_screen.dart';

class CommunityCard extends ConsumerWidget {
  final int communityId;
  final String title;
  final String description;
  final String category;
  final int memberCount;

  const CommunityCard(
      {Key? key,
      required this.communityId,
      required this.title,
      required this.description,
      required this.category,
      required this.memberCount})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.people),
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            Row(
              children: [
                Text(category),
                const SizedBox(width: 10),
                Text("멤버 ${memberCount.toString()}"),
              ],
            ),
          ],
        ),
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
                  CommunityDetailScreen(communityId),
            ),
          );
        },
      ),
    );
  }
}
