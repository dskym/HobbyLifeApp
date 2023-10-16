import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hobby_life_app/model/category_model.dart';
import 'package:hobby_life_app/model/community_model.dart';
import 'package:hobby_life_app/provider/category_provider.dart';
import 'package:hobby_life_app/provider/community_provider.dart';

class CommunityInputModal extends ConsumerStatefulWidget {
  final int? communityId;

  const CommunityInputModal({Key? key, this.communityId}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CommunityInputModalState();
}

class _CommunityInputModalState extends ConsumerState<CommunityInputModal> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? title;
  String? description;
  CategoryModel? category;

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
    if(widget.communityId != null) {
      return ref.watch(communityProvider(widget.communityId!)).when(
        data: (community) => getForm(communityModel: community),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => const Center(child: Text('에러 발생')),
      );
    } else {
      return getForm();
    }
  }

  Widget getForm({CommunityModel? communityModel}) {
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
                const Text('커뮤니티 개설'),
              ],
            ),
            TextFormField(
              initialValue: communityModel?.title ?? '',
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '이름',
                hintText: '커뮤니티 이름을 입력해주세요.',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return '커뮤니티 이름을 입력해주세요.';
                }
                return null;
              },
              onSaved: (newValue) => title = newValue,
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: communityModel?.description ?? '',
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '설명',
                hintText: '커뮤니티에 대한 설명을 입력해주세요.',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return '커뮤니티에 대한 설명을 입력해주세요.';
                }
                return null;
              },
              onSaved: (newValue) => description = newValue,
            ),
            const SizedBox(height: 10),
            ref.watch(categoryListProvider).when(
                data: (categoryList) {
                  final CategoryModel? model = categoryList.firstWhereOrNull(
                      (element) =>
                          element.name == communityModel?.categoryName);
                  return DropdownButtonFormField<CategoryModel>(
                    value: model,
                    hint: const Text('커뮤니티 카테고리를 선택해주세요.'),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: categoryList
                        .map<DropdownMenuItem<CategoryModel>>(
                            (CategoryModel category) =>
                                DropdownMenuItem<CategoryModel>(
                                  value: category,
                                  child: Text(category.name),
                                ))
                        .toList(),
                    onChanged: (value) => category = value,
                    onSaved: (newValue) => category = newValue,
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) =>
                    const Center(child: Text('에러 발생'))),
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

      if (widget.communityId == null) {
        ref.read(communityListProvider.notifier).createCommunity(
            title: title!, description: description!, categoryId: category!.id);
      } else {
        ref.read(communityListProvider.notifier).updateCommunity(
            communityId: widget.communityId!,
            title: title!,
            description: description!,
            categoryId: category!.id);
      }
      Navigator.of(context).pop();
    }
  }
}
