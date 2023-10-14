import 'package:hobby_life_app/model/hobby_history_model.dart';
import 'package:hobby_life_app/repository/hobby_history_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hobby_history_provider.g.dart';

final hobbyHistoryRepositoryProvider = Provider<HobbyHistoryRepository>((ref) => HobbyHistoryRepository());

@riverpod
class HobbyHistoryList extends _$HobbyHistoryList {
  @override
  Future<Map<String, List<HobbyHistoryModel>>> build(DateTime now) async {
    return ref.read(hobbyHistoryRepositoryProvider).getAllHobbyHistory(now);
  }

  Future<void> createHobbyHistory({required int hobbyId, required int score, required int cost, required DateTime hobbyDate}) async {
    final hobbyHistoryRepository = ref.read(hobbyHistoryRepositoryProvider);
    final hobbyHistoryModel = await hobbyHistoryRepository.addHobbyHistory(hobbyId: hobbyId, score: score, cost: cost, hobbyDate: hobbyDate);
    final previousState = await future;
    state = AsyncData({});
//    state = AsyncData([...previousState, hobbyHistoryModel]);
  }

  Future<void> deleteHobbyHistory({required int id}) async {
    final hobbyHistoryRepository = ref.read(hobbyHistoryRepositoryProvider);
    await hobbyHistoryRepository.deleteHobbyHistory(hobbyHistoryId: id);
    final previousState = await future;
    state = AsyncData({});
    // state = AsyncData(previousState.where((element) => element.id != id).toList());
  }

  Future<void> updateHobbyHistory({required int hobbyHistoryId, required int hobbyId, required int score, required int cost, required DateTime hobbyDate}) async {
    final hobbyHistoryRepository = ref.read(hobbyHistoryRepositoryProvider);
    final hobbyHistoryModel = await hobbyHistoryRepository.updateHobbyHistory(hobbyHistoryId: hobbyHistoryId, hobbyId: hobbyId, score: score, cost: cost, hobbyDate: hobbyDate);
    final previousState = await future;
    state = AsyncData({});
    // state = AsyncData(previousState.map((element) {
    //   if (element.id == hobbyHistoryId) {
    //     return element.copyWith(score: score, cost: cost, hobbyDate: hobbyDate);
    //   }
    //   return element;
    // }).toList());
  }

  Future<void> getHobbyHistory({required int hobbyHistoryId}) async {
    final hobbyHistoryRepository = ref.read(hobbyHistoryRepositoryProvider);
    final hobbyHistoryModel = await hobbyHistoryRepository.getHobbyHistory(hobbyHistoryId: hobbyHistoryId);
    state = AsyncData({});
    // state = AsyncData([hobbyHistoryModel]);
  }
}
