import 'package:flutter/material.dart';

class CommunityDetailScreen extends StatefulWidget {
  const CommunityDetailScreen({Key? key}) : super(key: key);

  @override
  State<CommunityDetailScreen> createState() => _CommunityDetailScreenState();
}

class _CommunityDetailScreenState extends State<CommunityDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('커뮤니티 상세'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('커뮤니티 상세'),
          ],
        ),
      ),
    );
  }
}
