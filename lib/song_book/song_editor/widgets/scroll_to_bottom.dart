import 'package:flutter/material.dart';

scrollToBottom(ScrollController controller) async {
  await Future.delayed(Duration(milliseconds: 240));
  await controller.animateTo(
      controller.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut
  );
}