import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:yaznaiver/ai_assistant/ai_assistant_message.dart';
import 'package:yaznaiver/ai_assistant/ai_assistant_message_bubble.dart';
import 'package:translator/translator.dart';

class AIChatPage extends StatefulWidget {
  const AIChatPage({super.key});

  @override
  _AIChatPageState createState() => _AIChatPageState();
}

class _AIChatPageState extends State<AIChatPage> {
  final List<Message> _messages = [];
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  final translator = GoogleTranslator(); // Initialize the translator

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.ai_assistant),
        actions: [
          IconButton(
            icon: const Icon(Icons.translate),
            onPressed: _translateMessage, // Add a translation function
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return MessageBubble(message: message);
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _inputController,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.type_your_message_hint,
                      border: const OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() async {
    if (_inputController.text.trim().isEmpty) return;

    final userMessage = Message(
      content: _inputController.text,
      isUser: true,
      text: '',
    );

    setState(() {
      _messages.add(userMessage);
      _isLoading = true;
    });

    _inputController.clear();
    _scrollToBottom();

    final url = Uri.parse("https://uncomfortable-christin-laiht-28d64b78.koyeb.app/essay/invoke");
    final headers = {
      "Content-Type": "application/json",
    };

    final body = jsonEncode({
      "input": {
        "symptoms": userMessage.content,
      },
    });

    late Message responseMessage;

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['output'] != null && jsonResponse['output']['content'] != null) {
          String content = jsonResponse['output']['content'];
          responseMessage = Message(
            content: content,
            isUser: false,
            text: '',
          );
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      responseMessage = Message(
        content: 'Error: ${e.toString()}',
        isUser: false,
        text: '',
      );
    }

    setState(() {
      _messages.add(responseMessage);
      _isLoading = false;
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // Translate the content to Arabic and show it in a popup
  void _translateMessage() async {
    if (_messages.isNotEmpty) {
      String content = _messages.last.content; // Get the last message content

      try {
        final translation = await translator.translate(content, to: 'ar');
        _showTranslationPopup(translation.text); // Show translation in a popup
      } catch (e) {
        print("Error translating message: $e");
      }
    }
  }

  // Show the translated content in a Popup window
  void _showTranslationPopup(String translatedText) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Translated Message"),
          content: Text(translatedText),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
