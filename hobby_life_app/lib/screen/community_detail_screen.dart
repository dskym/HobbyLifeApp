import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hobby_life_app/component/content_card.dart';
import 'package:hobby_life_app/component/content_input_modal.dart';
import 'package:hobby_life_app/provider/content_provider.dart';


class CommunityDetailScreen extends ConsumerStatefulWidget {
  const CommunityDetailScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommunityDetailScreenState();
}

class _CommunityDetailScreenState extends ConsumerState<CommunityDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('커뮤니티 이름'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('커뮤니티 상세 설명'),
            const Text('커뮤니티 참여 멤버'),
            const Text('게시글'),
            FutureBuilder(
              future: ref.watch(contentListProvider('1').future),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print(snapshot.data);
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ContentCard(
                        title: snapshot.data[index].title,
                        detail: snapshot.data[index].detail,
                        authorName: snapshot.data[index].authorName,
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        onPressed: () => showContentInputModal(context),
        child: const Icon(Icons.add),
      )
    );
  }

  void showContentInputModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      builder: (context) {
        return const ContentInputModal();
      },
    );
  }
}
