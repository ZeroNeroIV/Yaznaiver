import 'package:flutter/material.dart';
import 'package:yaznaiver/ai_assistant/ai_assistant_actual_message.dart';
import 'package:yaznaiver/ai_assistant/ai_assistant_avatar.dart';
import 'package:yaznaiver/ai_assistant/ai_assistant_chat_bubble.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage({required this.text, required this.isUser, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: isUser ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
                  children: [
                    Avater(isUser: isUser),
                    Column(
                      crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        ChatBubble(text: text, isUser: isUser),
                        ActualMessage(text: text, isUser: isUser),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
