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
    return FutureBuilder(
      future: ref.watch(userProvider.future),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final user = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.person,
                      size: 100,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 20),
                    Column(
                      children: [
                        Text(user.name),
                        const SizedBox(height: 10),
                        Text(user.email),
                      ],
                    )
                  ],
                ),
                const Divider(),
                const SizedBox(height: 10),
                // const Text('관심 있는 취미 생활'),
                // const SizedBox(height: 20),
                // Row(
                //   children: [
                //     Expanded(
                //       child: Wrap(
                //         spacing: 10,
                //         runSpacing: 10,
                //         children: _hobbyList
                //             .map((e) => Chip(
                //           label: Text(e),
                //         ))
                //             .toList(),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
