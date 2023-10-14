import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hobby_life_app/component/content_input_modal.dart';
import 'package:hobby_life_app/provider/content_provider.dart';

class ContentDetailScreen extends ConsumerStatefulWidget {
  const ContentDetailScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ContentDetailScreenState();
}

class _ContentDetailScreenState extends ConsumerState<ContentDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('글 제목'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              showContentInputModal(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              ref.read(contentListProvider('1').notifier).deleteContent(communityId: '1', contentId: '1');
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('세부 내용'),
            const Divider(),
            const Text('댓글'),
          ],
        ),
      ),
    );
  }

  void showContentInputModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      builder: (context) {
        return const ContentInputModal();
      },
    );
  }
}