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
  void initState() {
    super.initState();
    messageFormState = GlobalKey<FormState>();
    messagesListViewController = ScrollController();
  }

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
    return Builder(
      builder: (context) {
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
                      icon: const Icon(Icons.delete),
                      color: const Color.fromRGBO(0, 82, 218, 1.0),
                    ),
                    secondaryAction: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_back),
                      color: const Color.fromRGBO(0, 82, 218, 1.0),
                    ),
                  ),
                  messagesListView()
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget messagesListView() {
    if (chatPageProvider.messages != null) {
      if (chatPageProvider.messages!.isNotEmpty) {
        return Container(
          height: deviceHeight * 0.74,
          child: ListView.builder(
            itemCount: chatPageProvider.messages!.length,
            itemBuilder: (context, index) {
              return Container(
                child: Text(
                  chatPageProvider.messages![index].content,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
          ),
        );
      } else {
        return const Align(
          alignment: Alignment.center,
          child: Text(
            'Be the first one to say Hi!',
            style: TextStyle(color: Colors.white),
          ),
        );
      }
    } else {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }
  }
}
