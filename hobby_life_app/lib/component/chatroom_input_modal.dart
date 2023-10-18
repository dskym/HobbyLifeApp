import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hobby_life_app/model/category_model.dart';
import 'package:hobby_life_app/model/chatroom_model.dart';
import 'package:hobby_life_app/model/community_model.dart';
import 'package:hobby_life_app/provider/category_provider.dart';
import 'package:hobby_life_app/provider/chatroom_provider.dart';
import 'package:hobby_life_app/provider/community_provider.dart';

class ChatroomInputModal extends ConsumerStatefulWidget {
  final ChatroomModel? chatroomModel;

  const ChatroomInputModal({Key? key, this.chatroomModel}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChatroomInputModalState();
}

class _ChatroomInputModalState extends ConsumerState<ChatroomInputModal> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int? chatroomId;
  String? name;
  String? description;

  @override
  void initState() {
    super.initState();
    if(widget.chatroomModel != null) {
      chatroomId = widget.chatroomModel?.chatroomId ?? 0;
      name = widget.chatroomModel?.name ?? '';
      description = widget.chatroomModel?.description ?? '';
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
                const Text('채팅방 개설'),
              ],
            ),
            TextFormField(
              initialValue: name,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '이름',
                hintText: '채팅방 이름을 입력해주세요.',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return '채팅방 이름을 입력해주세요.';
                }
                return null;
              },
              onSaved: (newValue) => name = newValue!,
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: description,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '설명',
                hintText: '채팅방에 대한 설명을 입력해주세요.',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return '채팅방에 대한 설명을 입력해주세요.';
                }
                return null;
              },
              onSaved: (newValue) => description = newValue!,
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

      if(widget.chatroomModel == null) {
        ref.read(chatroomListProvider.notifier)
          .createChatroom(name: name!, description: description!);
      } else {
        ref.read(chatroomListProvider.notifier)
            .updateChatroom(chatroomId: chatroomId!, name: name!, description: description!);
      }
      Navigator.of(context).pop();
    }
  }
}
