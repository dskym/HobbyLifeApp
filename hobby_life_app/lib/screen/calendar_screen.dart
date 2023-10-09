import 'package:flutter/material.dart';
import 'package:hobby_life_app/component/hobby_history_card.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
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
    List<HobbyHistoryCard> hobbyHistoryCardList = <HobbyHistoryCard>[
      const HobbyHistoryCard(
          hobbyName: "hobby1",
          categoryName: "category1",
          score: 0,
          cost: 0,
          startTime: "10:00:00",
          endTime: "11:00:00"),
      const HobbyHistoryCard(
          hobbyName: "hobby2",
          categoryName: "category2",
          score: 10,
          cost: 20,
          startTime: "12:00:00",
          endTime: "14:00:00"),
      const HobbyHistoryCard(
          hobbyName: "hobby3",
          categoryName: "category3",
          score: 20,
          cost: 40,
          startTime: "15:00:00",
          endTime: "18:00:00"),
      const HobbyHistoryCard(
          hobbyName: "hobby4",
          categoryName: "category4",
          score: 30,
          cost: 60,
          startTime: "16:00:00",
          endTime: "20:00:00"),
    ];

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
          firstDay: DateTime.utc(1900, 1, 11),
          lastDay: DateTime.utc(2100, 12, 31),
          currentDay: DateTime.now(),
          focusedDay: selectedDate,
          locale: 'ko_KR',
          onDaySelected: (selectedDay, focusedDay) {
            _onSelectedDay(selectedDay);
          },
          selectedDayPredicate: (day) {
            return isSameDay(day, selectedDate);
          },
        ),
        const Divider(
          height: 1,
          thickness: 1,
          color: Colors.black,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: hobbyHistoryCardList.length,
            itemBuilder: (context, index) {
              return hobbyHistoryCardList[index];
            },
          ),
        ),
      ],
    );
  }

  void _onSelectedDay(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }
}
