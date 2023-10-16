import 'package:hobby_life_app/model/hobby_history_model.dart';
import 'package:hobby_life_app/repository/hobby_history_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hobby_history_provider.g.dart';

final hobbyHistoryRepositoryProvider = Provider<HobbyHistoryRepository>((ref) => HobbyHistoryRepository());

@riverpod
class HobbyHistory extends _$HobbyHistory {
  @override
  Future<HobbyHistoryModel> build(int hobbyHistoryId) async {
    final hobbyHistoryRepository = ref.watch(hobbyHistoryRepositoryProvider);
    return await hobbyHistoryRepository.getHobbyHistory(hobbyHistoryId: hobbyHistoryId);
  }
}

@riverpod
class HobbyHistoryList extends _$HobbyHistoryList {
  @override
  Future<Map<String, List<HobbyHistoryModel>>> build(DateTime now) async {
    return ref.watch(hobbyHistoryRepositoryProvider).getAllHobbyHistory(now);
  }

  Future<void> createHobbyHistory({required int categoryId, required String name, required String hobbyDate, required String startTime, required String endTime, required String? memo, required int? score, required int? cost}) async {
    final hobbyHistoryRepository = ref.watch(hobbyHistoryRepositoryProvider);
    final hobbyHistoryModel = await hobbyHistoryRepository.addHobbyHistory(categoryId: categoryId, name: name, hobbyDate: hobbyDate, startTime: startTime, endTime: endTime, memo: memo, score: score, cost: cost);
    final previousState = await future;
    previousState[hobbyDate] = [...previousState[hobbyDate] ?? [], hobbyHistoryModel];
    state = AsyncData(Map.from(previousState));
    ref.invalidate(hobbyHistoryListProvider);
  }

  Future<void> deleteHobbyHistory({required int id}) async {
    final hobbyHistoryRepository = ref.watch(hobbyHistoryRepositoryProvider);
    await hobbyHistoryRepository.deleteHobbyHistory(hobbyHistoryId: id);
    final previousState = await future;
    previousState.forEach((key, value) {
      previousState[key] = value.where((element) => element.id != id).toList();
    });
    state = AsyncData(Map.from(previousState));
    ref.invalidate(hobbyHistoryListProvider);
  }

  Future<void> updateHobbyHistory({required int hobbyHistoryId, required int categoryId, required String name, required String hobbyDate, required String startTime, required String endTime, required String? memo, required int? score, required int? cost}) async {
    final hobbyHistoryRepository = ref.watch(hobbyHistoryRepositoryProvider);
    final hobbyHistoryModel = await hobbyHistoryRepository.updateHobbyHistory(hobbyHistoryId: hobbyHistoryId, categoryId: categoryId, name: name, hobbyDate: hobbyDate, startTime: startTime, endTime: endTime, memo: memo, score: score, cost: cost);
    final previousState = await future;
    state = AsyncData({
      hobbyDate: previousState[hobbyDate]!.map((element) {
        if (element.id == hobbyHistoryId) {
          return hobbyHistoryModel;
        }
        return element;
      }).toList(),
    });
    ref.invalidate(hobbyHistoryListProvider);
  }
}
