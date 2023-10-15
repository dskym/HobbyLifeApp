import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hobby_life_app/model/content_model.dart';
import 'package:hobby_life_app/provider/content_provider.dart';

class ContentInputModal extends ConsumerStatefulWidget {
  final int? communityId;
  final ContentModel? contentModel;

  const ContentInputModal({Key? key, this.communityId, this.contentModel}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContentInputModalState();
}

class _ContentInputModalState extends ConsumerState<ContentInputModal> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? title;
  String? detail;

  @override
  void initState() {
    super.initState();
    if(widget.contentModel != null) {
      title = widget.contentModel?.title ?? '';
      detail = widget.contentModel?.detail ?? '';
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => goBackScreen(context),
                ),
                const SizedBox(width: 10),
                const Text('커뮤니티 글 작성'),
              ],
            ),
            TextFormField(
              initialValue: title,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '제목',
                hintText: '글 제목을 입력해주세요.',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return '글 제목을 입력해주세요.';
                }
                return null;
              },
              onSaved: (newValue) => title = newValue!,
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: detail,
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '내용',
                hintText: '글 내용을 입력해주세요.',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return '글 내용을 입력해주세요.';
                }
                return null;
              },
              onSaved: (newValue) => detail = newValue!,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => onSave(context),
              child: const Text('저장'),
            ),
          ],
        ),
      ),
    );
  }


  goBackScreen(BuildContext context) async {
    Navigator.of(context).pop();
  }

  onSave(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      if(widget.contentModel != null) {
        ref.read(contentListProvider(widget.communityId!.toString()).notifier).updateContent(
          communityId: widget.communityId!.toString(),
          contentId: widget.contentModel!.contentId.toString(),
          title: title!,
          detail: detail!,
        );
      } else {
        ref.read(contentListProvider(widget.communityId!.toString()).notifier).createContent(
          communityId: '1',
          title: title!,
          detail: detail!,
        );
      }
    }

    Navigator.of(context).pop();
  }
}