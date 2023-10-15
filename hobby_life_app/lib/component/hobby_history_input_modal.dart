import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hobby_life_app/provider/hobby_history_provider.dart';

class HobbyHistoryInputModal extends ConsumerStatefulWidget {
  const HobbyHistoryInputModal({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HobbyHistoryInputModalState();
}

class _HobbyHistoryInputModalState
    extends ConsumerState<HobbyHistoryInputModal> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String hobbyDate = '';
  String hobbyName = '';
  String categoryName = '';
  int score = 0;
  int cost = 0;
  String startTime = '';
  String endTime = '';

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
                  icon: const Icon(Icons.keyboard_arrow_left_outlined),
                  onPressed: () => goBackScreen(context),
                ),
                const SizedBox(width: 10),
                const Text('취미 활동 기록'),
              ],
            ),
            TextFormField(
              initialValue: hobbyName,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: '이름',
                hintText: '취미 이름을 입력해주세요.',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return '취미 이름을 입력해주세요.';
                }
                return null;
              },
              onSaved: (newValue) => hobbyName = newValue!,
            ),
            TextFormField(
              initialValue: hobbyDate,
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(
                labelText: '취미 날짜',
                hintText: '취미 날짜를 입력해주세요.',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return '취미 날짜를 입력해주세요.';
                }
                return null;
              },
              onSaved: (newValue) => hobbyDate = newValue!,
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
            TextFormField(
              initialValue: score.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '만족도',
                hintText: '만족도를 입력해주세요.',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return '만족도를 입력해주세요.';
                }
                return null;
              },
              onSaved: (newValue) => score = newValue! as int,
            ),
            TextFormField(
              initialValue: cost.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '비용',
                hintText: '비용을 입력해주세요.',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return '비용을 입력해주세요.';
                }
                return null;
              },
              onSaved: (newValue) => cost = newValue! as int,
            ),
            TextFormField(
              initialValue: cost.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '비용',
                hintText: '비용을 입력해주세요.',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return '비용을 입력해주세요.';
                }
                return null;
              },
              onSaved: (newValue) => cost = newValue! as int,
            ),
            TextFormField(
              initialValue: startTime,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '시작 시간',
                hintText: '시작 시간을 입력해주세요.',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return '시작 시간을 입력해주세요.';
                }
                return null;
              },
              onSaved: (newValue) => startTime = newValue!,
            ),
            TextFormField(
              initialValue: endTime,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '종료 시간',
                hintText: '종료 시간을 입력해주세요.',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return '종료 시간을 입력해주세요.';
                }
                return null;
              },
              onSaved: (newValue) => endTime = newValue!,
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

      ref.read(hobbyHistoryListProvider(DateTime.now()).notifier)
          .createHobbyHistory(
              hobbyId: 1, score: score, cost: cost, hobbyDate: DateTime.now());
    }
    Navigator.of(context).pop();
  }
}
