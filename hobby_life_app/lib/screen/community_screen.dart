import 'package:flutter/material.dart';
import 'package:hobby_life_app/component/community_card.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> _tabs = <Tab>[
    const Tab(text: '전체 커뮤니티'),
    const Tab(text: '내가 가입한 커뮤니티'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _tabs,
        ),
        Expanded(
          child: TabBarView(controller: _tabController, children: [
            getAllCommunity(),
            getMyCommunity(),
          ]),
        ),
      ],
    );
  }

  Widget getAllCommunity() {
    final List<String> entries = <String>[
      'A',
      'B',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M'
    ];

    return ListView.builder(
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return CommunityCard(
          title: "커뮤니티 ${entries[index]}",
          description: "커뮤니티 ${entries[index]} 설명",
          category: "커뮤니티 ${entries[index]} 카테고리",
          memberCount: 10,
        );
      },
    );
  }

  Widget getMyCommunity() {
    final List<String> entries = <String>[
      'A',
      'B',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M'
    ];

    return ListView.builder(
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return CommunityCard(
          title: "커뮤니티 ${entries[index]}",
          description: "커뮤니티 ${entries[index]} 설명",
          category: "커뮤니티 ${entries[index]} 카테고리",
          memberCount: 10,
        );
      },
    );
  }
}
