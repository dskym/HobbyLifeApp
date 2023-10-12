import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hobby_life_app/model/category_model.dart';
import 'package:hobby_life_app/repository/category_repository.dart';

final categoryProvider = FutureProvider.autoDispose<CategoryRepository>((ref) => CategoryRepository());