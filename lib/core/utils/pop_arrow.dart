import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PopArrow extends StatelessWidget {
  const PopArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        GoRouter.of(context).pop();
      },
    );
  }
}
