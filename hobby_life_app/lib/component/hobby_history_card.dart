import 'package:flutter/material.dart';
import 'hobby_history_input_modal.dart';

class HobbyHistoryCard extends StatelessWidget {
  final int id;
  final String name;
  final int categoryId;
  final String hobbyDate;
  final String startTime;
  final String endTime;
  final int? score;
  final int? cost;
  final String? memo;

  const HobbyHistoryCard(
      {Key? key,
      required this.id,
      required this.name,
      required this.categoryId,
      required this.hobbyDate,
      required this.startTime,
      required this.endTime,
      required this.score,
      required this.cost,
      required this.memo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.history),
        title: Text(name),
        subtitle: Row(
          children: [
            Text(categoryId.toString()),
            const SizedBox(width: 10),
            Text('${score ?? 0}점'),
            const SizedBox(width: 10),
            Text('${cost ?? 0}원'),
            const SizedBox(width: 10),
            Text('$startTime ~ $endTime'),
          ],
        ),
        onTap: () => showHobbyHistoryInputModal(context),
      ),
    );
  }

  showHobbyHistoryInputModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      builder: (context) {
        return HobbyHistoryInputModal(hobbyHistoryId: id);
      },
    );
  }
}
