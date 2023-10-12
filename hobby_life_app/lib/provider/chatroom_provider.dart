import 'package:hobby_life_app/repository/chatroom_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final chatroomProvider = FutureProvider.autoDispose<ChatroomRepository>((ref) => ChatroomRepository());