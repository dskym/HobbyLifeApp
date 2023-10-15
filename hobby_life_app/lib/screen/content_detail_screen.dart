import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hobby_life_app/component/comment_card.dart';
import 'package:hobby_life_app/component/content_input_modal.dart';
import 'package:hobby_life_app/model/comment_model.dart';
import 'package:hobby_life_app/model/content_model.dart';
import 'package:hobby_life_app/provider/comment_provider.dart';
import 'package:hobby_life_app/provider/content_provider.dart';

class ContentDetailScreen extends ConsumerStatefulWidget {
  final int communityId;
  final int contentId;

  const ContentDetailScreen(this.communityId, this.contentId, {Key? key})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ContentDetailScreenState();
}

class _ContentDetailScreenState extends ConsumerState<ContentDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ref.watch(contentProvider(
              widget.communityId.toString(), widget.contentId.toString())
          .future),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final content = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text(content.title),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    showContentInputModal(context, content);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    ref
                        .read(contentListProvider(widget.communityId.toString())
                            .notifier)
                        .deleteContent(
                            communityId: widget.communityId.toString(),
                            contentId: widget.contentId.toString());
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text('세부 내용'),
                    Text(content.detail),
                    const Divider(),
                    const Text('작성자'),
                    Text(content.authorName),
                    const Divider(),
                    const Text('댓글'),
                    FutureBuilder(
                      future: ref.watch(commentListProvider('1', '2').future),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          print(snapshot.data);
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              final CommentModel comment = snapshot.data[index];
                              return CommentCard(
                                  commentId: comment.commentId,
                                  detail: comment.detail,
                                  authorName: comment.authorName,
                                  lastModified: comment.lastModified);
                            },
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            bottomSheet: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '댓글 입력',
              ),
              onSubmitted: (String value) {
                ref
                    .read(commentListProvider(widget.communityId.toString(), widget.contentId.toString()).notifier)
                    .createComment(
                        communityId: widget.communityId.toString(),
                        contentId: widget.contentId.toString(),
                        detail: value,
                        originCommentId: null);
              },
            )
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void showContentInputModal(BuildContext context, ContentModel contentModel) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      builder: (context) {
        return ContentInputModal(
            communityId: widget.communityId, contentModel: contentModel);
      },
    );
  }
}
