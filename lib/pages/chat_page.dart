import 'package:chatify_app/models/chat.dart';
import 'package:chatify_app/providers/authentication_provider.dart';
import 'package:chatify_app/providers/chat_page_provider.dart';
import 'package:chatify_app/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final Chat chat;
  const ChatPage({super.key, required this.chat});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late double deviceHeight;
  late double deviceWidth;
  late AuthenticationProvieder authenticationProvieder;
  late ChatPageProvider chatPageProvider;
  late GlobalKey<FormState> messageFormState;
  late ScrollController messagesListViewController;
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    authenticationProvieder = Provider.of<AuthenticationProvieder>(context);
    return MultiProvider(providers: [
      ChangeNotifierProvider<ChatPageProvider>(
        create: (context) => ChatPageProvider(
          authenticationProvieder,
          messagesListViewController,
          widget.chat.uid,
        ),
      )
    ], child: buildUI());
  }

  Widget buildUI() {
    return Builder(builder: (context) {
      chatPageProvider = context.watch<ChatPageProvider>();
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: deviceWidth * 0.03,
              vertical: deviceHeight * 0.02,
            ),
            height: deviceHeight * 0.98,
            width: deviceWidth * 0.97,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TopBar(
                  barTitle: this.widget.chat.title(),
                  fontSize: 20,
                  primaryAction: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.delete),
                    color: Color.fromRGBO(0, 82, 218, 1.0),
                  ),
                  secondaryAction: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_back),
                    color: Color.fromRGBO(0, 82, 218, 1.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
