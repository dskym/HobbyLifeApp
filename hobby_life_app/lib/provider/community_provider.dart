import 'package:hobby_life_app/repository/community_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final communityProvider = FutureProvider.autoDispose<CommunityRepository>((ref) => CommunityRepository());