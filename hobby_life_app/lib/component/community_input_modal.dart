import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hobby_life_app/model/category_model.dart';
import 'package:hobby_life_app/model/community_model.dart';
import 'package:hobby_life_app/provider/category_provider.dart';
import 'package:hobby_life_app/provider/community_provider.dart';

class CommunityInputModal extends ConsumerStatefulWidget {
  final CommunityModel? communityModel;

  const CommunityInputModal({Key? key, this.communityModel}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CommunityInputModalState();
}

class _CommunityInputModalState extends ConsumerState<CommunityInputModal> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? title;
  String? description;
  String? categoryName;
  int? categoryId;

  @override
  void initState() {
    super.initState();
    if(widget.communityModel != null) {
      title = widget.communityModel?.title ?? '';
      description = widget.communityModel?.description ?? '';
      categoryName = widget.communityModel?.categoryName ?? '';
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
                const Text('커뮤니티 개설'),
              ],
            ),
            TextFormField(
              initialValue: title,
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
              onSaved: (newValue) => title = newValue!,
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: description,
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
              onSaved: (newValue) => description = newValue!,
            ),
            const SizedBox(height: 10),
            FutureBuilder<List<CategoryModel>>(
              future: ref.read(categoryListProvider.future),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return DropdownButtonFormField<CategoryModel>(
                    value: null,
                    hint: const Text('커뮤니티 카테고리를 선택해주세요.'),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: snapshot.data
                        .map<DropdownMenuItem<CategoryModel>>(
                            (CategoryModel category) =>
                                DropdownMenuItem<CategoryModel>(
                                  value: category,
                                  child: Text(category.name),
                                ))
                        .toList(),
                    onChanged: (value) => categoryId = value?.id ?? 0,
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
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

      if(widget.communityModel == null) {
        ref
            .read(communityListProvider.notifier)
            .createCommunity(title: title!, description: description!, categoryId: categoryId!);
      } else {
        ref.read(communityListProvider.notifier)
            .updateCommunity(id: widget.communityModel!.communityId.toString(), title: title!, description: description!, categoryId: categoryId!);
      }
    }
    Navigator.of(context).pop();
  }
}
