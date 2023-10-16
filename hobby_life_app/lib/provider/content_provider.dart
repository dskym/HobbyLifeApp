import 'package:hobby_life_app/model/content_model.dart';
import 'package:hobby_life_app/provider/community_provider.dart';
import 'package:hobby_life_app/repository/content_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'content_provider.g.dart';

final contentRepositoryProvider = Provider<ContentRepository>((ref) => ContentRepository());

@riverpod
class Content extends _$Content {
  @override
  Future<ContentModel> build(int communityId, int contentId) async {
    List<ContentModel> contentModelList = await ref.watch(contentListProvider(communityId).future);
    return contentModelList.firstWhere((element) => element.contentId == contentId);
  }
}

@riverpod
class ContentList extends _$ContentList {
  @override
  Future<List<ContentModel>> build(int communityId) async {
    final communityModel = await ref.watch(communityProvider(communityId).future);
    return ref.watch(contentRepositoryProvider).getAllContent(communityId: communityModel.communityId);
  }

  Future<void> createContent({required int communityId, required String title, required String detail}) async {
    final contentRepository = ref.watch(contentRepositoryProvider);
    final contentModel = await contentRepository.createContent(communityId: communityId, title: title, detail: detail);
    final previousState = await future;
    state = AsyncData([...previousState, contentModel]);
  }

  Future<void> deleteContent({required int communityId, required int contentId}) async {
    final contentRepository = ref.watch(contentRepositoryProvider);
    await contentRepository.deleteContent(communityId: communityId, contentId: contentId);
    final previousState = await future;
    state = AsyncData(previousState.where((element) => element.contentId != contentId).toList());
  }

  Future<void> updateContent({required int communityId, required int contentId, required String title, required String detail}) async {
    final contentRepository = ref.watch(contentRepositoryProvider);
    final contentModel = await contentRepository.updateContent(communityId: communityId, contentId: contentId, title: title, detail: detail);
    final previousState = await future;
    state = AsyncData(previousState.map((element) {
      if (element.contentId == contentId) {
        return contentModel;
      }
      return element;
    }).toList());
  }
}