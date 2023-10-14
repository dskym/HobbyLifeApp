import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hobby_life_app/component/community_card.dart';
import 'package:hobby_life_app/model/community_model.dart';
import 'package:hobby_life_app/provider/community_provider.dart';

class CommunityScreen extends ConsumerStatefulWidget {
  const CommunityScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends ConsumerState<CommunityScreen>
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
    return FutureBuilder(
      future: ref.watch(communityListProvider.future),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              TabBar(
                controller: _tabController,
                tabs: _tabs,
                onTap: (index) => changeTabBarEvent(index),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    getAllCommunity(snapshot.data),
                    getMyCommunity(snapshot.data),
                ]),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void changeTabBarEvent(int index) {
    switch (index) {
      case 0:
        ref.read(communityListProvider.notifier).getAllCommunity();
        break;
      case 1:
        ref.read(communityListProvider.notifier).joinCommunity();
        break;
    }
  }

  Widget getAllCommunity(List<CommunityModel> communityList) {
    return ListView.builder(
      itemCount: communityList.length,
      itemBuilder: (BuildContext context, int index) {
        return CommunityCard(
          title: communityList[index].title,
          description: communityList[index].description,
          category: communityList[index].categoryName,
          memberCount: 10,
        );
      },
    );
  }

  Widget getMyCommunity(List<CommunityModel> communityList) {
    return ListView.builder(
      itemCount: communityList.length,
      itemBuilder: (BuildContext context, int index) {
        return CommunityCard(
          title: communityList[index].title,
          description: communityList[index].description,
          category: communityList[index].categoryName,
          memberCount: 10,
        );
      },
    );
  }
}
