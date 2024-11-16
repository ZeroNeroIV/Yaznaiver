import 'package:flutter/material.dart';

class Avater extends StatelessWidget {
  final bool isUser;

  const Avater({required this.isUser, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(right: 16.0),
      child: CircleAvatar(
        backgroundColor: isUser ? Colors.blue : Colors.green,
        child: Text(isUser ? 'U' : 'AI'),
      ),
    );
  }
}
