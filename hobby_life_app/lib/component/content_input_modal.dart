import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hobby_life_app/model/content_model.dart';
import 'package:hobby_life_app/provider/content_provider.dart';

class ContentInputModal extends ConsumerStatefulWidget {
  final int? communityId;
  final int? contentId;

  const ContentInputModal({Key? key, this.communityId, this.contentId}) : super(key: key);

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
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.communityId != null && widget.contentId != null) {
      return ref.watch(contentProvider(widget.communityId!, widget.contentId!)).when(
        data: (contentModel) => getForm(contentModel: contentModel),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => const Center(child: Text('에러')),
      );
    } else {
      return getForm();
    }
  }

  Widget getForm({ContentModel? contentModel}) {
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
              initialValue: contentModel?.title ?? '',
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
              onSaved: (newValue) => title = newValue,
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: contentModel?.detail ?? '',
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
              onSaved: (newValue) => detail = newValue,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
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

      if(widget.communityId != null && widget.contentId != null) {
        ref.read(contentListProvider(widget.communityId!).notifier).updateContent(
          communityId: widget.communityId!,
          contentId: widget.contentId!,
          title: title!,
          detail: detail!,
        );
      } else {
        ref.read(contentListProvider(widget.communityId!).notifier).createContent(
          communityId: widget.communityId!,
          title: title!,
          detail: detail!,
        );
      }
      Navigator.of(context).pop();
    }
  }
}