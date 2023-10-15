import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentCard extends ConsumerWidget {
  final int commentId;
  final String detail;
  final String authorName;
  final DateTime lastModified;

  const CommentCard({Key? key, required this.commentId, required this.detail, required this.authorName, required this.lastModified}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Stack(
        children: [
          ListTile(
            title: Text(detail),
            subtitle: Text(authorName),
            trailing: Text(lastModified.toString()),
          ),
          Positioned(
            top: 8.0,
            right: 8.0,
            child: PopupMenuButton<String>(
              onSelected: (value) {
                if(value == 'delete') {

                } else if(value == 'edit') {

                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Text('수정'),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('삭제'),
                  ),
                ];
              },
            )
          ),
        ],
      )
    );
  }
}