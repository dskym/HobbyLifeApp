import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hobby_life_app/model/category_model.dart';
import 'package:hobby_life_app/repository/category_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_provider.g.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) => CategoryRepository());

@riverpod
class CategoryList extends _$CategoryList {
  @override
  Future<List<CategoryModel>> build() async {
    return ref.read(categoryRepositoryProvider).getAllCategory();
  }

  Future<void> createCategory({required String categoryName}) async {
    final categoryRepository = ref.read(categoryRepositoryProvider);
    final categoryModel = await categoryRepository.createCategory(categoryName: categoryName);
    final previousState = await future;
    state = AsyncData([...previousState, categoryModel]);
  }

  Future<void> deleteCategory({required int id}) async {
    final categoryRepository = ref.read(categoryRepositoryProvider);
    await categoryRepository.deleteCategory(id: id);
    final previousState = await future;
    state = AsyncData(previousState.where((element) => element.id != id).toList());
  }
}