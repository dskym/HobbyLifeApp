import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hobby_life_app/provider/community_provider.dart';
import 'package:hobby_life_app/screen/community_detail_screen.dart';

class CommunityCard extends ConsumerWidget {
  final int id;
  final String title;
  final String description;
  final String category;
  final int memberCount;

  const CommunityCard(
      {Key? key,
      required this.id,
      required this.title,
      required this.description,
      required this.category,
      required this.memberCount})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      confirmDismiss: (DismissDirection direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("삭제"),
              content: const Text("정말 삭제하시겠습니까?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("취소"),
                ),
                TextButton(
                  onPressed: () => {
                    ref
                        .read(communityListProvider.notifier)
                        .deleteCommunity(id: id.toString()),
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('삭제되었습니다.'),
                      ),
                    ),
                    Navigator.of(context).pop(true),
                  },
                  child: const Text("삭제"),
                ),
              ],
            );
          },
        );
      },
      background: Container(
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
      ),
      child: Card(
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
                    CommunityDetailScreen(id),
              ),
            );
          },
        ),
      ),
    );
  }
}
