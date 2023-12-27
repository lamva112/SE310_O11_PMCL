import 'package:chatgpt_api_client/chatgpt_api_client.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final ChatUser _currentUser =
      ChatUser(id: '1', firstName: "Lam", lastName: 'Bui');
  final ChatUser _gptUser =
      ChatUser(id: '2', firstName: "Panda", lastName: 'Lecture');
  ChatGptApiClient client = ChatGptApiClient(
      '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',
      ChatGptModelOption(stream: false, maxPropmtStack: 3));
  List<ChatMessage> messages = <ChatMessage>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DashChat(
        currentUser: _currentUser,
        onSend: (ChatMessage m) {
          setState(() {
            messages.insert(0, m);
          });

          client.sendMessage(m.text, onData: (ChatGptApiResponse response) {
            setState(() {
              messages.insert(
                  0,
                  ChatMessage(
                      user: _gptUser,
                      createdAt: DateTime.now(),
                      text: response.choices[0].text));
            });
          }, onStreamData: (ChatGptApiResponse response) {
            print(response);
          }, onStreamEnd: () {
            print('end');
          });
        },
        messages: messages,
      ),
    );
  }
}
