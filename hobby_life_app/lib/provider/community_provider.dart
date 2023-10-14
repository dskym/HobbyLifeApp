import 'package:hobby_life_app/model/community_model.dart';
import 'package:hobby_life_app/repository/community_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'community_provider.g.dart';

final communityRepositoryProvider = Provider<CommunityRepository>((ref) => CommunityRepository());

@riverpod
class Community extends _$Community {
  @override
  Future<CommunityModel> build(String communityId) async {
    return ref.read(communityRepositoryProvider).getCommunity(communityId: communityId);
  }

  Future<void> joinCommunity({required String id}) async {
    final communityRepository = ref.read(communityRepositoryProvider);
    final communityModel = await communityRepository.joinCommunity(communityId: id);
    state = AsyncData(communityModel);
  }

  Future<void> leaveCommunity({required String id}) async {
    final communityRepository = ref.read(communityRepositoryProvider);
    await communityRepository.leaveCommunity(communityId: id);
  }
}

@riverpod
class CommunityList extends _$CommunityList {
  @override
  Future<List<CommunityModel>> build() async {
    return ref.read(communityRepositoryProvider).getAllCommunity();
  }

  Future<void> createCommunity({required String title, required String description, required int categoryId}) async {
    final communityModel = await ref.read(communityRepositoryProvider).createCommunity(title: title, description: description, categoryId: categoryId);
    final previousState = await future;
    state = AsyncData([...previousState, communityModel]);
  }

  Future<void> deleteCommunity({required String id}) async {
    final communityRepository = ref.read(communityRepositoryProvider);
    await communityRepository.deleteCommunity(communityId: id);
    final previousState = await future;
    state = AsyncData(previousState.where((element) => element.communityId != id).toList());
  }

  Future<void> updateCommunity({required String id, required String title, required String description, required int categoryId}) async {
    final communityRepository = ref.read(communityRepositoryProvider);
    final communityModel = await communityRepository.updateCommunity(communityId: id, title: title, description: description, categoryId: categoryId);
    final previousState = await future;
    state = AsyncData(previousState.map((element) {
      if (element.communityId.toString() == id) {
        return element.copyWith(title: title, description: description, categoryName: communityModel.categoryName);
      }
      return element;
    }).toList());
  }

  Future<void> getAllCommunity() async {
    final communityRepository = ref.read(communityRepositoryProvider);
    final communityModel = await communityRepository.getAllCommunity();
    state = AsyncData(communityModel);
  }

  Future<void> joinCommunity() async {
    final communityRepository = ref.read(communityRepositoryProvider);
    final communityModel = await communityRepository.getJoinCommunity();
    state = AsyncData(communityModel);
  }
}
