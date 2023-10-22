import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hobby_life_app/component/community_input_modal.dart';
import 'package:hobby_life_app/component/content_card.dart';
import 'package:hobby_life_app/component/content_input_modal.dart';
import 'package:hobby_life_app/model/community_model.dart';
import 'package:hobby_life_app/provider/community_provider.dart';
import 'package:hobby_life_app/provider/content_provider.dart';
import 'package:hobby_life_app/provider/user_provider.dart';

class CommunityDetailScreen extends ConsumerStatefulWidget {
  final int communityId;

  const CommunityDetailScreen(this.communityId, {Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CommunityDetailScreenState();
}

class _CommunityDetailScreenState extends ConsumerState<CommunityDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ref.watch(communityProvider(widget.communityId).future),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final community = snapshot.data;
          return Scaffold(
              appBar: AppBar(
                title: Text(community.title),
                centerTitle: true,
                actions: [
                  ref.watch(userProvider).when(
                        data: (user) {
                          if (user.userId == community.authorId) {
                            return IconButton(
                              onPressed: () =>
                                  showCommunityInputModal(context, community),
                              icon: const Text('수정'),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                        loading: () => const SizedBox(),
                        error: (error, stackTrace) => const SizedBox(),
                      ),
                  community.isJoin
                      ? IconButton(
                          onPressed: () {
                            ref
                                .read(communityListProvider.notifier)
                                .leaveCommunity(
                                    communityId: widget.communityId);
                            Navigator.pop(context);
                          },
                          icon: const Text('탈퇴'),
                        )
                      : IconButton(
                          onPressed: () {
                            ref
                                .read(communityListProvider.notifier)
                                .joinCommunity(communityId: widget.communityId);
                            Navigator.pop(context);
                          },
                          icon: const Text('가입'),
                        ),
                ],
              ),
              body: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '설명',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Text(community.description),
                    const SizedBox(height: 20),
                    const Text(
                      '게시글',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    FutureBuilder(
                      future: ref.watch(
                          contentListProvider(widget.communityId).future),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ContentCard(
                                communityId: widget.communityId,
                                contentId: snapshot.data[index].contentId,
                                title: snapshot.data[index].title,
                                detail: snapshot.data[index].detail,
                                authorName: snapshot.data[index].authorName,
                              );
                            },
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
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
              ));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void showCommunityInputModal(
      BuildContext context, CommunityModel communityModel) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      builder: (context) {
        return CommunityInputModal(communityId: widget.communityId);
      },
    );
  }

  void showContentInputModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      builder: (context) {
        return ContentInputModal(communityId: widget.communityId);
      },
    );
  }
}
