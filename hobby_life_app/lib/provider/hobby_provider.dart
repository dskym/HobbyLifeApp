import 'package:hobby_life_app/model/hobby_model.dart';
import 'package:hobby_life_app/repository/hobby_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hobby_provider.g.dart';

final hobbyRepositoryProvider = Provider<HobbyRepository>((ref) => HobbyRepository());

@riverpod
class HobbyList extends _$HobbyList {
  @override
  Future<List<HobbyModel>> build() async {
    return [];
  }

  Future<void> createHobby({required int categoryId, required String hobbyName}) async {
    final hobbyRepository = ref.read(hobbyRepositoryProvider);
    final hobbyModel = await hobbyRepository.createHobby(categoryId: categoryId, hobbyName: hobbyName);
    final previousState = await future;
    state = AsyncData([...previousState, hobbyModel]);
  }

  Future<void> deleteHobby({required int id}) async {
    final hobbyRepository = ref.read(hobbyRepositoryProvider);
    await hobbyRepository.deleteHobby(id: id);
    final previousState = await future;
    state = AsyncData(previousState.where((element) => element.id != id.toString()).toList());
  }

  Future<void> geyHobbyByCatgory({required int categoryId}) async {
    final hobbyRepository = ref.read(hobbyRepositoryProvider);
    final hobbyModel = await hobbyRepository.getHobbyByCategory(categoryId: categoryId);
    state = AsyncData(hobbyModel);
  }
}