import 'package:flutter/material.dart';
import 'hobby_history_input_modal.dart';

class HobbyHistoryCard extends StatelessWidget {
  final String hobbyName;
  final String categoryName;
  final int score;
  final int cost;
  final String startTime;
  final String endTime;

  const HobbyHistoryCard(
      {Key? key,
      required this.hobbyName,
      required this.categoryName,
      required this.score,
      required this.cost,
      required this.startTime,
      required this.endTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.history),
        title: Text(hobbyName),
        subtitle: Row(
          children: [
            Text(categoryName),
            const SizedBox(width: 10),
            Text('$score 점'),
            const SizedBox(width: 10),
            Text('$cost 원'),
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
        return const HobbyHistoryInputModal();
      },
    );
  }
}
