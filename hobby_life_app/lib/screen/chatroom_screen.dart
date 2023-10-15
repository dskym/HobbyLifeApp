import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hobby_life_app/component/chat_message.dart';
import 'package:hobby_life_app/model/chat_message_model.dart';
import 'package:hobby_life_app/provider/chat_provider.dart';
import 'package:hobby_life_app/provider/chatroom_provider.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import 'dart:convert';

class ChatroomScreen extends ConsumerStatefulWidget {
  final int id;
  final String name;

  const ChatroomScreen({super.key, required this.id, required this.name});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends ConsumerState<ChatroomScreen> {
  late ScrollController _scrollController;
  late TextEditingController _textEditingController;

  StompClient? _client;

  void onConnect(StompFrame frame) {
    _client!.subscribe(
        destination: '/sub/chat/room/${widget.id}',
        callback: (StompFrame frame) {
          ChatMessageModel chatMessageModel = ChatMessageModel.fromJson(jsonDecode(frame.body!));
          ref.read(ChatProvider(widget.id).notifier).addMessage(chatMessageModel);
          _scrollController
              .jumpTo(_scrollController.position.maxScrollExtent);
        });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _textEditingController = TextEditingController();

    if(_client == null) {
      _client = StompClient(
        config: StompConfig.sockJS(
          url: 'http://172.30.1.17:8080/ws/chatroom',
          onConnect: onConnect,
        ),
      );
      _client!.activate();
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  void dispose() {
    _client!.deactivate();
    _scrollController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: ref.watch(chatProvider(widget.id)).when(
                  data: (List<ChatMessageModel> chatList) {
                    return ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: chatList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ChatMessage(
                          message: chatList[index].message,
                          name: chatList[index].memberName,
                          isMe: chatList[index].isMe,
                          time: chatList[index].time,
                        );
                      },
                    );
                  },
                  error: (Object error, StackTrace? stackTrace) {
                    return const Text('error');
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
            const Divider(height: 1),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      print('Send Button is clicked');
                      _client!.send(
                          destination: '/pub/chat/message',
                          body:
                          '{"chatroomId": ${widget.id}, "memberId": 1, "message": "${_textEditingController.text}"}');
                      _scrollController
                          .jumpTo(_scrollController.position.maxScrollExtent);
                      _textEditingController.clear();
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          children: [
            const Text('채팅방 참여 멤버'),
            FutureBuilder(
              future: ref.watch(chatroomMemberListProvider(widget.id).future),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(snapshot.data[index].name),
                        onTap: () {
                          print('Item 1 is clicked');
                        },
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(chatroomProvider(widget.id).notifier)
                    .leaveChatroom(id: widget.id);
                Navigator.pop(context);
              },
              child: Text('나가기'),
            ),
          ],
        ),
      ),
    );
  }
}
