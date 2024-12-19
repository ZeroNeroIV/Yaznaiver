import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatBubble({required this.text, required this.isUser, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      padding: const EdgeInsets.only(right: 25),
      margin: const EdgeInsets.only(top: 5.0),
      child: Text(
        isUser ? AppLocalizations.of(context)!.you : AppLocalizations.of(context)!.ai_assistant,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
