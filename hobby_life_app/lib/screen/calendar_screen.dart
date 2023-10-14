import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hobby_life_app/component/hobby_history_card.dart';
import 'package:hobby_life_app/provider/hobby_history_provider.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ref.watch(hobbyHistoryListProvider(selectedDate).future),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final sel = DateFormat('yyyy-MM-dd').format(selectedDate);
          return Column(
            children: [
              TableCalendar(
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                calendarStyle: const CalendarStyle(
                  isTodayHighlighted: false,
                  weekendTextStyle: TextStyle(
                    color: Colors.red,
                  ),
                  holidayTextStyle: TextStyle(
                    color: Colors.blue,
                  ),
                  markersAlignment: Alignment.bottomRight,
                ),
                firstDay: DateTime.utc(1900, 1, 1),
                lastDay: DateTime.utc(2100, 12, 31),
                currentDay: DateTime.now(),
                focusedDay: selectedDate,
                locale: 'ko_KR',
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    selectedDate = selectedDay;
                  });
                },
                onPageChanged: (focusedDay) {
                  selectedDate = focusedDay;
                },
                selectedDayPredicate: (day) {
                  return isSameDay(day, selectedDate);
                },
                eventLoader: (day) {
                  final sel = DateFormat('yyyy-MM-dd').format(day);
                  return snapshot.data[sel] ?? [];
                },
              ),
              const Divider(
                height: 1,
                thickness: 1,
                color: Colors.black,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data[sel]?.length ?? 0,
                  itemBuilder: (context, index) {
                    final hobbyHistory = snapshot.data[sel][index];
                    return HobbyHistoryCard(
                        hobbyName: hobbyHistory.hobbyName,
                        categoryName: "",
                        score: hobbyHistory.score,
                        cost: hobbyHistory.cost,
                        startTime: "12:00:00",
                        endTime: "14:00:00");
                  },
                ),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
