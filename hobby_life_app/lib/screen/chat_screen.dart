import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hobby_life_app/component/chatroom_card.dart';
import 'package:hobby_life_app/model/chatroom_model.dart';
import 'package:hobby_life_app/provider/chatroom_provider.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> _tabs = <Tab>[
    const Tab(text: '전체 채팅방'),
    const Tab(text: '내가 가입한 채팅방'),
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
      future: ref.watch(chatroomListProvider.future),
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
        ref.read(chatroomListProvider.notifier).getAllChatroom();
        break;
      case 1:
        ref.read(chatroomListProvider.notifier).getJoinChatroom();
        break;
    }
  }

  Widget getAllCommunity(List<ChatroomModel> chatroomList) {
    return ListView.builder(
      itemCount: chatroomList.length,
      itemBuilder: (BuildContext context, int index) {
        return ChatroomCard(
          chatroomId: chatroomList[index].chatroomId,
          name: chatroomList[index].name,
          description: chatroomList[index].description,
          lastMessageTime: DateTime.now(),
        );
      },
    );
  }

  Widget getMyCommunity(List<ChatroomModel> chatroomList) {
    return ListView.builder(
      itemCount: chatroomList.length,
      itemBuilder: (BuildContext context, int index) {
        return ChatroomCard(
          chatroomId: chatroomList[index].chatroomId,
          name: chatroomList[index].name,
          description: chatroomList[index].description,
          lastMessageTime: DateTime.now(),
        );
      },
    );
  }
}