import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hobby_life_app/component/error_component.dart';
import 'package:hobby_life_app/model/category_model.dart';
import 'package:hobby_life_app/model/hobby_history_model.dart';
import 'package:hobby_life_app/provider/category_provider.dart';
import 'package:hobby_life_app/provider/hobby_history_provider.dart';
import 'package:hobby_life_app/util/CategoryUtils.dart';
import 'package:intl/intl.dart';

class HobbyHistoryInputModal extends ConsumerStatefulWidget {
  final int? hobbyHistoryId;

  const HobbyHistoryInputModal({Key? key, this.hobbyHistoryId})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HobbyHistoryInputModalState();
}

class _HobbyHistoryInputModalState
    extends ConsumerState<HobbyHistoryInputModal> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController hobbyDateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  String? name;
  String? hobbyDate;
  String? startTime;
  String? endTime;
  CategoryModel? category;
  int? score;
  int? cost;
  String? memo;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    hobbyDateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.hobbyHistoryId != null) {
      return ref.watch(hobbyHistoryProvider(widget.hobbyHistoryId!)).when(
        data: (hobbyHistory) => getForm(hobbyHistoryModel: hobbyHistory),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => const ErrorComponent(),
      );
    } else {
      return getForm();
    }
  }

  Widget getForm({HobbyHistoryModel? hobbyHistoryModel}) {
    hobbyDateController.text = hobbyHistoryModel?.hobbyDate ?? '';
    startTimeController.text = hobbyHistoryModel?.startTime ?? '';
    endTimeController.text = hobbyHistoryModel?.endTime ?? '';

    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Form(
      key: formKey,
      child: Container(
        height: MediaQuery.of(context).size.height + bottomInset,
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: bottomInset + 20,
          ),
          child: SingleChildScrollView(
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
                initialValue: hobbyHistoryModel?.name ?? '',
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '이름',
                  hintText: '취미 이름을 입력해주세요.',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return '취미 이름을 입력해주세요.';
                  }
                  return null;
                },
                onSaved: (newValue) => name = newValue,
              ),
              const SizedBox(height: 10),
              ref.watch(categoryListProvider).when(
                  data: (categoryList) {
                    final CategoryModel? model = categoryList.firstWhereOrNull(
                            (element) =>
                        element.id == hobbyHistoryModel?.categoryId);
                    return DropdownButtonFormField<CategoryModel>(
                      value: model,
                      hint: const Text('카테고리를 선택해주세요.'),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      items: categoryList
                          .map<DropdownMenuItem<CategoryModel>>(
                              (CategoryModel category) =>
                              DropdownMenuItem<CategoryModel>(
                                value: category,
                                child: Row(
                                  children: [
                                    CategoryUtils.getCategoryIcon(category.id),
                                    const SizedBox(width: 10),
                                    Text(category.name),
                                  ],
                                ),
                              ))
                          .toList(),
                      validator: (CategoryModel? value) {
                        if (value == null) {
                          return '카테고리를 선택해주세요.';
                        }
                        return null;
                      },
                      onChanged: (value) => category = value,
                      onSaved: (newValue) => category = newValue,
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) =>
                  const Center(child: Text('에러 발생'))),
              const SizedBox(height: 10),
              TextFormField(
                controller: hobbyDateController,
                readOnly: true,
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateFormat('yyyy-MM-dd').parse(hobbyHistoryModel?.hobbyDate ?? DateFormat('yyyy-MM-dd').format(DateTime.now())),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    hobbyDateController.text = DateFormat('yyyy-MM-dd').format(picked);
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '취미 날짜',
                  hintText: '취미 날짜를 입력해주세요.',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return '취미 날짜를 입력해주세요.';
                  }
                  return null;
                },
                onSaved: (newValue) => hobbyDate = newValue,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: startTimeController,
                readOnly: true,
                onTap: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(DateFormat('HH:mm:ss').parse(hobbyHistoryModel?.startTime ?? DateFormat('HH:mm:ss').format(DateTime.now()))),
                    initialEntryMode: TimePickerEntryMode.input,
                  );
                  if (picked != null) {
                    startTimeController.text = "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}:00";
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '시작 시간',
                  hintText: '시작 시간을 입력해주세요.',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return '시작 시간을 입력해주세요.';
                  }
                  return null;
                },
                onSaved: (newValue) => startTime = newValue,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: endTimeController,
                readOnly: true,
                onTap: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(DateFormat('HH:mm:ss').parse(hobbyHistoryModel?.endTime ?? DateFormat('HH:mm:ss').format(DateTime.now()))),
                    initialEntryMode: TimePickerEntryMode.input,
                  );
                  if (picked != null) {
                    endTimeController.text = "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}:00";
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '종료 시간',
                  hintText: '종료 시간을 입력해주세요.',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return '종료 시간을 입력해주세요.';
                  }
                  return null;
                },
                onSaved: (newValue) => endTime = newValue,
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: hobbyHistoryModel?.score?.toString(),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '만족도',
                  hintText: '만족도를 입력해주세요.',
                ),
                validator: (String? value) {
                  if(value != null && value.isNotEmpty) {
                    if(int.tryParse(value) == null) {
                      return '숫자를 입력해주세요.';
                    }
                    if (int.parse(value) < 0 || int.parse(value) > 5) {
                      return '0 ~ 5 사이의 숫자를 입력해주세요.';
                    }
                  }
                  return null;
                },
                onSaved: (newValue) => score = (newValue != null && newValue.isNotEmpty) ? int.parse(newValue) : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: hobbyHistoryModel?.cost?.toString(),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '비용',
                  hintText: '비용을 입력해주세요.',
                ),
                validator: (String? value) {
                  if(value != null && value.isNotEmpty) {
                    if(int.tryParse(value) == null) {
                      return '숫자를 입력해주세요.';
                    }
                    if (int.parse(value) < 0 || int.parse(value) > 5) {
                      return '0 ~ 5 사이의 숫자를 입력해주세요.';
                    }
                  }
                  return null;
                },
                onSaved: (newValue) => cost = (newValue != null && newValue.isNotEmpty) ? int.parse(newValue) : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: hobbyHistoryModel?.memo ?? '',
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                maxLength: 300,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '메모',
                  hintText: '메모를 입력해주세요.',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return '메모를 입력해주세요.';
                  }
                  return null;
                },
                onSaved: (newValue) => memo = newValue,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () => onSave(context),
                child: const Text('저장하기'),
              ),
            ],
        ),
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

      if(widget.hobbyHistoryId != null) {
        ref.read(hobbyHistoryListProvider(DateTime.now()).notifier)
            .updateHobbyHistory(
            hobbyHistoryId: widget.hobbyHistoryId!,
            categoryId: category!.id,
            name: name!,
            hobbyDate: hobbyDate!,
            startTime: startTime!,
            endTime: endTime!,
            memo: memo,
            score: score,
            cost: cost
        );
      } else {
        ref.read(hobbyHistoryListProvider(DateTime.now()).notifier)
            .createHobbyHistory(
            categoryId: category!.id,
            name: name!,
            hobbyDate: hobbyDate!,
            startTime: startTime!,
            endTime: endTime!,
            memo: memo,
            score: score,
            cost: cost
        );
      }
      Navigator.of(context).pop();
    }
  }
}
