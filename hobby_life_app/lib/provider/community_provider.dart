import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hobby_life_app/model/community_model.dart';
import 'package:hobby_life_app/repository/community_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'community_provider.g.dart';

final communityRepositoryProvider = Provider<CommunityRepository>((ref) => CommunityRepository());
final communityCategoryProvider = StateProvider<int>((ref) => 0);

@riverpod
class Community extends _$Community {
  @override
  Future<CommunityModel> build(int communityId) async {
    List<CommunityModel> communityModelList = await ref.watch(communityListProvider.future);
    return communityModelList.firstWhere((element) => element.communityId == communityId);
  }
}

@riverpod
class CommunityList extends _$CommunityList {
  @override
  Future<List<CommunityModel>> build() async {
    return ref.watch(communityRepositoryProvider).getAllCommunity();
  }

  Future<void> createCommunity({required String title, required String description, required int categoryId}) async {
    final communityModel = await ref.watch(communityRepositoryProvider).createCommunity(title: title, description: description, categoryId: categoryId);
    final previousState = await future;
    state = AsyncData([...previousState, communityModel]);
  }

  Future<void> deleteCommunity({required int communityId}) async {
    final communityRepository = ref.watch(communityRepositoryProvider);
    await communityRepository.deleteCommunity(communityId: communityId);
    final previousState = await future;
    state = AsyncData(previousState.where((element) => element.communityId != communityId).toList());
  }

  Future<void> getAllCommunity() async {
    final communityRepository = ref.watch(communityRepositoryProvider);
    final communityModel = await communityRepository.getAllCommunity();
    state = AsyncData(communityModel);
  }

  Future<void> updateCommunity({required int communityId, required String title, required String description, required int categoryId}) async {
    final communityRepository = ref.watch(communityRepositoryProvider);
    final communityModel = await communityRepository.updateCommunity(communityId: communityId, title: title, description: description, categoryId: categoryId);
    final previousState = await future;
    state = AsyncData(previousState.map((element) {
      if (element.communityId == communityId) {
        return communityModel;
      }
      return element;
    }).toList());
  }

  Future<void> getJoinCommunity() async {
    final communityRepository = ref.watch(communityRepositoryProvider);
    final communityModel = await communityRepository.getJoinCommunity();
    state = AsyncData(communityModel);
  }

  Future<void> joinCommunity({required int communityId}) async {
    final communityRepository = ref.watch(communityRepositoryProvider);
    await communityRepository.joinCommunity(communityId: communityId);
    ref.invalidateSelf();
  }

  Future<void> leaveCommunity({required int communityId}) async {
    final communityRepository = ref.watch(communityRepositoryProvider);
    await communityRepository.leaveCommunity(communityId: communityId);
    ref.invalidateSelf();
  }
}
