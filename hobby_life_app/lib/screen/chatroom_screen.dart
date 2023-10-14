import 'package:flutter/material.dart';
import 'package:hobby_life_app/component/chat_message.dart';

class ChatroomScreen extends StatefulWidget {
  final String name;

  const ChatroomScreen({super.key, required this.name});

  @override
  State<ChatroomScreen> createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen> {
  ScrollController _scrollController = ScrollController();

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
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                print('Item 1 is clicked');
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                print('Item 2 is clicked');
              },
            ),
            ListTile(
              title: const Text('Item 3'),
              onTap: () {
                print('Item 3 is clicked');
              },
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
