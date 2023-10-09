import 'package:flutter/material.dart';
import 'package:hobby_life_app/component/community_input_modal.dart';
import 'package:hobby_life_app/component/hobby_history_input_modal.dart';

import 'calendar_screen.dart';
import 'chat_screen.dart';
import 'community_screen.dart';
import 'info_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1;

  final List<Widget> _widgetOptions = <Widget>[
    const CalendarScreen(),
    const CommunityScreen(),
    ChatScreen(),
    const InfoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HobbyLifeApp'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              print('Settings Button is clicked');
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: '취미 캘린더',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: '커뮤니티',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: '채팅방',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: '내정보',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      floatingActionButton: _selectedIndex == 0 || _selectedIndex == 1
          ? FloatingActionButton(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: const CircleBorder(),
              onPressed: () => showInputModal(_selectedIndex),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  void showInputModal(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        showHobbyHistoryInputModal(context);
        break;
      case 1:
        showCommunityInputModal(context);
        break;
      default:
        break;
    }
  }

  void showHobbyHistoryInputModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      builder: (context) {
        return const HobbyHistoryInputModal();
      },
    );
  }

  void showCommunityInputModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      builder: (context) {
        return const CommunityInputModal();
      },
    );
  }
}
