import 'package:flutter/material.dart';

class CommunityInputModal extends StatefulWidget {
  const CommunityInputModal({Key? key}) : super(key: key);

  @override
  State<CommunityInputModal> createState() => _CommunityInputModalState();
}

class _CommunityInputModalState extends State<CommunityInputModal> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String title = '';
  String description = '';
  String categoryName = '';

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
                const Text('커뮤니티 생성'),
              ],
            ),
            TextFormField(
              initialValue: title,
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(
                labelText: '커뮤니티 이름',
                hintText: '커뮤니티 이름을 입력해주세요.',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return '커뮤니티 이름을 입력해주세요.';
                }
                return null;
              },
              onSaved: (newValue) => title = newValue!,
            ),
            TextFormField(
              initialValue: description,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: '커뮤니티에 대한 설명',
                hintText: '커뮤니티에 대한 설명을 입력해주세요.',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return '커뮤니티에 대한 설명을 입력해주세요.';
                }
                return null;
              },
              onSaved: (newValue) => description = newValue!,
            ),
            TextFormField(
              initialValue: categoryName,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: '카테고리',
                hintText: '카테고리를 선택해주세요.',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return '카테고리를 선택해주세요.';
                }
                return null;
              },
              onSaved: (newValue) => categoryName = newValue!,
            ),
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
