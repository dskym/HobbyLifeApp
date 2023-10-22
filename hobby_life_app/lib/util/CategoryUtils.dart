import 'package:flutter/material.dart';

class CategoryUtils {
  CategoryUtils._();

  static Icon getCategoryIcon(int categoryId) {
    switch (categoryId) {
      case 1:
        return const Icon(Icons.sports);
      case 2:
        return const Icon(Icons.music_note_rounded);
      case 3:
        return const Icon(Icons.book);
      case 4 :
        return const Icon(Icons.photo_camera);
      case 5 :
        return const Icon(Icons.language);
      case 6 :
        return const Icon(Icons.dinner_dining_outlined);
      case 7 :
        return const Icon(Icons.movie);
      case 8 :
        return const Icon(Icons.gamepad);
      case 9 :
        return const Icon(Icons.travel_explore);
      case 10 :
        return const Icon(Icons.shopping_cart);
      default:
        return const Icon(Icons.abc);
    }
  }
}