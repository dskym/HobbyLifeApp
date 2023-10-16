import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hobby_life_app/provider/comment_provider.dart';

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
          subtitle: Text(authorName),
          trailing: Text(lastModified.toString()),
        ),
        Positioned(
            top: 8.0,
            right: 8.0,
            child: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'delete') {
                  deleteComment(communityId, contentId, commentId);
                } else if (value == 'edit') {
                  updateComment(communityId, contentId, commentId, detail);
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: 'edit',
                    child: Text('수정하기'),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text('삭제하기'),
                  ),
                ];
              },
            )),
      ],
    ));
  }
}
