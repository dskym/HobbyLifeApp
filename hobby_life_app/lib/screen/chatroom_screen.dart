import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hobby_life_app/component/chat_message.dart';
import 'package:hobby_life_app/model/user_model.dart';
import 'package:hobby_life_app/provider/chatroom_provider.dart';

class ChatroomScreen extends ConsumerStatefulWidget {
  final int id;
  final String name;

  const ChatroomScreen({super.key, required this.id, required this.name});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends ConsumerState<ChatroomScreen> {
  final ScrollController _scrollController = ScrollController();

  List<ChatMessage> messages = <ChatMessage>[
    ChatMessage(
      name: '김철수',
      message: '안녕하세요',
      time: DateTime.now(),
      isMe: true,
    ),
    ChatMessage(
      name: '김영희',
      message: '안녕하세요',
      time: DateTime.now(),
      isMe: false,
    ),
    ChatMessage(
      name: '김철수',
      message: '안녕하세요',
      time: DateTime.now(),
      isMe: true,
    ),
    ChatMessage(
      name: '김영희',
      message: '안녕하세요',
      time: DateTime.now(),
      isMe: false,
    ),
    ChatMessage(
      name: '김철수',
      message: '안녕하세요',
      time: DateTime.now(),
      isMe: true,
    ),
    ChatMessage(
      name: '김영희',
      message: '안녕하세요',
      time: DateTime.now(),
      isMe: false,
    ),
    ChatMessage(
      name: '김철수',
      message: '안녕하세요',
      time: DateTime.now(),
      isMe: true,
    ),
    ChatMessage(
      name: '김영희',
      message: '안녕하세요',
      time: DateTime.now(),
      isMe: false,
    ),
    ChatMessage(
      name: '김철수',
      message: '안녕하세요',
      time: DateTime.now(),
      isMe: true,
    ),
    ChatMessage(
      name: '김영희',
      message: '안녕하세요',
      time: DateTime.now(),
      isMe: false,
    ),
  ];


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: messages.length,
        itemBuilder: (BuildContext context, int index) {
          return messages[index];
        },
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
                ref.read(chatroomProvider(widget.id).notifier).leaveChatroom(id: widget.id);
              },
              child: Text('나가기'),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '메시지를 입력하세요',
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                print('Send Button is clicked');
                _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
              },
              icon: const Icon(Icons.send),
            ),
          ],
        ),
      )
    );
  }
}
