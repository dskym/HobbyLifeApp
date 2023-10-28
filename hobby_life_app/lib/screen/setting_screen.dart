import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hobby_life_app/provider/user_auth_provider.dart';
import 'package:hobby_life_app/provider/user_provider.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({Key? key}) : super(key: key);

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('설정'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('공지사항'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('준비중입니다.')));
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('개인정보처리방침'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // TODO: notion 링크 연결 후 웹뷰 띄우기
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('회원 탈퇴'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              ref.read(userRepositoryProvider).leaveUser();
              _storage.delete(key: 'accessToken');
              _storage.delete(key: 'refreshToken');
              ref.read(isLoginProvider.notifier).update((state) => false);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('로그아웃'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              _storage.delete(key: 'accessToken');
              _storage.delete(key: 'refreshToken');
              ref.read(isLoginProvider.notifier).update((state) => false);
              Navigator.of(context).pop();
            },
          ),
          const ListTile(
            title: Text('버전정보'),
            trailing: Text('1.0.0'),
          ),
        ],
      )
    );
  }
}