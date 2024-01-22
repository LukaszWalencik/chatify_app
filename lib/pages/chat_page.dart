import 'package:chatify_app/providers/authentication_provider.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late double deviceHeight;
  late double deviceWeight;
  late AuthenticationProvieder authenticationProvieder;
  late GlobalKey<FormState> messageFormState;
  late ScrollController messageListViewController;
  @override
  Widget build(BuildContext context) {
    return buildUI();
  }

  Widget buildUI() {
    return Scaffold();
  }
}
