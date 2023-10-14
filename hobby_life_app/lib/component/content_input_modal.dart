import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hobby_life_app/provider/content_provider.dart';

class ContentInputModal extends ConsumerStatefulWidget {
  final String? title;
  final String? detail;

  const ContentInputModal({Key? key, this.title, this.detail}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContentInputModalState();
}

class _ContentInputModalState extends ConsumerState<ContentInputModal> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
              initialValue: widget.title ?? '',
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: '제목',
                hintText: '글 제목을 입력해주세요.',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return '글 제목을 입력해주세요.';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: widget.detail ?? '',
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              decoration: const InputDecoration(
                labelText: '내용',
                hintText: '글 내용을 입력해주세요.',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return '글 내용을 입력해주세요.';
                }
                return null;
              },
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
    }
    Navigator.of(context).pop();
  }
}