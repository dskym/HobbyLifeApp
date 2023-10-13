import 'package:hobby_life_app/model/content_model.dart';
import 'package:hobby_life_app/repository/content_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'content_provider.g.dart';

final contentRepositoryProvider = Provider<ContentRepository>((ref) => ContentRepository());

@riverpod
class ContentList extends _$ContentList {
  @override
  Future<List<ContentModel>> build(String communityId) async {
    return ref.read(contentRepositoryProvider).getAllContent(communityId: communityId);
  }
}

@riverpod
class Content extends _$Content {
  @override
  Future<ContentModel> build(String communityId, String contentId) async {
    return ref.read(contentRepositoryProvider).getContent(communityId: communityId, contentId: contentId);
  }

  Future<void> createContent({required String communityId, required String title, required String detail}) async {
    final contentRepository = ref.read(contentRepositoryProvider);
    final contentModel = await contentRepository.createContent(communityId: communityId, title: title, detail: detail);
    state = AsyncData(contentModel);
  }

  Future<void> deleteContent({required String communityId, required String contentId}) async {
    final contentRepository = ref.read(contentRepositoryProvider);
    await contentRepository.deleteContent(communityId: communityId, contentId: contentId);
  }

  Future<void> updateContent({required String communityId, required String contentId, required String title, required String detail}) async {
    final contentRepository = ref.read(contentRepositoryProvider);
    final contentModel = await contentRepository.updateContent(communityId: communityId, contentId: contentId, title: title, detail: detail);
    state = AsyncData(contentModel);
  }
}