import 'package:flutter/material.dart';

class ErrorComponent extends StatelessWidget {
  const ErrorComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('에러가 발생했습니다.'),
    );
  }
}