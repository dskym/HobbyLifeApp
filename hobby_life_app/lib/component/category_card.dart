import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hobby_life_app/provider/community_provider.dart';
import 'package:hobby_life_app/util/CategoryUtils.dart';

class CategoryCard extends ConsumerWidget {
  final int categoryId;
  final String categoryName;

  const CategoryCard({Key? key, required this.categoryId, required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategoryId = ref.watch(communityCategoryProvider);
    return GestureDetector(
      onTap: () {
        ref.read(communityCategoryProvider.notifier).update((state) => categoryId);
      },
      child: Container(
        width: 60,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
          color: selectedCategoryId == categoryId ? Colors.grey[200] : Colors.white,
        ),
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        child: Column(
          children: [
            CategoryUtils.getCategoryIcon(categoryId),
            const SizedBox(height: 10),
            Text(categoryName),
          ],
        ),
      ),
    );
  }
}