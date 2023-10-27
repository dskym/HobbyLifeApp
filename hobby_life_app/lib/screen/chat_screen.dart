import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hobby_life_app/component/chatroom_card.dart';
import 'package:hobby_life_app/model/chat_message_model.dart';
import 'package:hobby_life_app/model/chatroom_model.dart';
import 'package:hobby_life_app/provider/chat_provider.dart';
import 'package:hobby_life_app/provider/chatroom_provider.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

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

  StompClient? _client;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);

    if(_client == null) {
      _client = StompClient(
        config: StompConfig.sockJS(
          url: 'http://10.0.2.2:8080/ws/chatroom',
          onConnect: onConnect,
        ),
      );
      _client!.activate();
    }
  }

  void onConnect(StompFrame frame) async {
    final chatroomList = await ref.read(chatroomRepositoryProvider).getJoinChatroom();
    for (ChatroomModel chatroom in chatroomList) {
      _client!.subscribe(
          destination: '/sub/chat/room/${chatroom.chatroomId}',
          callback: (StompFrame frame) {
            ChatMessageModel chatMessageModel = ChatMessageModel.fromJson(jsonDecode(frame.body!));
            ref.read(ChatProvider(chatroom.chatroomId).notifier).addMessage(chatMessageModel);
            print(frame.body);
          });
    }
  }

  @override
  void dispose() {
    _client!.deactivate();
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
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: [
                      getAllChatroom(snapshot.data),
                      getMyChatroom(snapshot.data),
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

  Widget getAllChatroom(List<ChatroomModel> chatroomList) {
    return ListView.builder(
      itemCount: chatroomList.length,
      itemBuilder: (BuildContext context, int index) {
        return ChatroomCard(
          chatroomId: chatroomList[index].chatroomId,
          name: chatroomList[index].name,
          description: chatroomList[index].description,
          isJoin: chatroomList[index].isJoin,
          lastMessage: null,
          lastMessageTime: null,
        );
      },
    );
  }

  Widget getMyChatroom(List<ChatroomModel> chatroomList) {
    return ListView.builder(
      itemCount: chatroomList.length,
      itemBuilder: (BuildContext context, int index) {
        final chatMessage = ref.watch(ChatProvider(chatroomList[index].chatroomId));
        return ref.watch(ChatProvider(chatroomList[index].chatroomId)).when(
          data: (List<ChatMessageModel> chatList) {
            return ChatroomCard(
              chatroomId: chatroomList[index].chatroomId,
              name: chatroomList[index].name,
              description: chatroomList[index].description,
              isJoin: chatroomList[index].isJoin,
              lastMessage: chatList.isNotEmpty ? chatList.last.message : null,
              lastMessageTime: chatList.isNotEmpty ? chatList.last.time : null,
            );
          },
          error: (Object error, StackTrace? stackTrace) => const Text('error'),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}