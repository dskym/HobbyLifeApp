import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hobby_life_app/provider/user_provider.dart';

class InfoScreen extends ConsumerWidget {
  InfoScreen({super.key});

  final List<String> _hobbyList = <String>[
    '운동',
    '음악',
    '영화',
    '게임',
    '요리',
    '독서',
    '공부',
    '여행',
    '드라이브',
    '그림',
    '사진',
    '봉사',
    '기타',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: ref.watch(userProvider.future),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: const Icon(
                    Icons.person,
                    size: 100,
                    color: Colors.grey,
                  ),
                ),
                Center(
                  child: Text(user.name),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(user.email),
                ),
                const SizedBox(height: 20),
                const Text('관심 있는 취미 생활'),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: _hobbyList
                            .map((e) => Chip(
                          label: Text(e),
                        ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('많이 한 취미 생활'),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: _hobbyList
                            .map((e) => Chip(
                          label: Text(e),
                        ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
                const Text('많이 비용을 쓴 취미 생활'),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: _hobbyList
                            .map((e) => Chip(
                          label: Text(e),
                        ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
                const Text('가장 만족한 취미 생활'),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: _hobbyList
                            .map((e) => Chip(
                          label: Text(e),
                        ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
