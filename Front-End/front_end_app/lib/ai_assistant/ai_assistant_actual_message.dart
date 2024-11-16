import 'package:flutter/material.dart';

class ActualMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ActualMessage({required this.text, required this.isUser, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      padding: const EdgeInsets.only(right: 25),
      margin: const EdgeInsets.only(top: 5.0),
      child: Text(
        text,
        softWrap: true,
        overflow: TextOverflow.fade,
      ),
    );
  }
}
