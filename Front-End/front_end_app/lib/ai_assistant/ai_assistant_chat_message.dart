import 'package:flutter/material.dart';

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
        isUser ? 'You' : 'AI Assistant',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

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
