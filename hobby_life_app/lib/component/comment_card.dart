import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hobby_life_app/provider/comment_provider.dart';
import 'package:intl/intl.dart';

class CommentCard extends ConsumerWidget {
  final int communityId;
  final int contentId;
  final int commentId;
  final String detail;
  final String authorName;
  final DateTime lastModified;
  final Function updateComment;
  final Function deleteComment;

  const CommentCard(
      {Key? key,
      required this.communityId,
      required this.contentId,
      required this.commentId,
      required this.detail,
      required this.authorName,
      required this.lastModified,
      required this.updateComment,
      required this.deleteComment})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
        child: Stack(
      children: [
        ListTile(
          title: Text(detail),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(authorName),
              const SizedBox(width: 10),
              Text(DateFormat('yyyy-MM-dd HH:mm:ss').format(lastModified)),
            ],
          ),
        ),
        Positioned(
            top: 0.0,
            right: 4.0,
            child: PopupMenuButton<String>(
              icon: const Icon(Icons.more_horiz),
              onSelected: (value) {
                if (value == 'delete') {
                  deleteComment(communityId, contentId, commentId);
                } else if (value == 'edit') {
                  updateComment(communityId, contentId, commentId, detail);
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Text('수정하기'),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('삭제하기'),
                  ),
                ];
              },
            )
        ),
      ],
    ));
  }
}
