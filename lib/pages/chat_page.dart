import 'package:chatify_app/models/chat.dart';
import 'package:chatify_app/models/chat_message.dart';
import 'package:chatify_app/providers/authentication_provider.dart';
import 'package:chatify_app/providers/chat_page_provider.dart';
import 'package:chatify_app/widgets/custom_input_field.dart';
import 'package:chatify_app/widgets/custom_list_view_tiles.dart';
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
                    barTitle: widget.chat.title(),
                    fontSize: 20,
                    primaryAction: IconButton(
                      onPressed: () {
                        chatPageProvider.deleteChat();
                      },
                      icon: const Icon(Icons.delete),
                      color: const Color.fromRGBO(0, 82, 218, 1.0),
                    ),
                    secondaryAction: IconButton(
                      onPressed: () {
                        chatPageProvider.goBack();
                      },
                      icon: const Icon(Icons.arrow_back),
                      color: const Color.fromRGBO(0, 82, 218, 1.0),
                    ),
                  ),
                  messagesListView(),
                  sendMessageForm(),
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
              ChatMessage message = chatPageProvider.messages![index];
              bool isOwnMessage =
                  message.senderID == authenticationProvieder.chatUser.uid;
              return Container(
                child: CustomChatListViewTile(
                  width: deviceWidth,
                  height: deviceHeight,
                  isOwnMessage: isOwnMessage,
                  chatMessage: message,
                  chatUser: widget.chat.members
                      .where((m) => m.uid == message.senderID)
                      .first,
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

  Widget sendMessageForm() {
    return Container(
      height: deviceHeight * 0.06,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(30, 29, 37, 1),
        borderRadius: BorderRadius.circular(100),
      ),
      margin: EdgeInsets.symmetric(
          horizontal: deviceWidth * 0.04, vertical: deviceHeight * 0.03),
      child: Form(
        key: messageFormState,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            messageTextField(),
            sendMessageButton(),
            imageMessageButton(),
          ],
        ),
      ),
    );
  }

  Widget messageTextField() {
    return SizedBox(
      width: deviceWidth * 0.65,
      child: CustomTextFormField(
          onSaved: (value) {
            chatPageProvider.message = value;
          },
          regEx: r"^(?!\s*$).+",
          hintText: 'Type a message',
          obscureText: false),
    );
  }

  Widget sendMessageButton() {
    double size = deviceHeight * 0.04;
    return Container(
      height: size,
      width: size,
      child: IconButton(
        onPressed: () {
          if (messageFormState.currentState!.validate()) {
            messageFormState.currentState!.save();
            chatPageProvider.sendTextMessage();
            messageFormState.currentState!.reset();
          }
        },
        icon: Icon(
          Icons.send,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget imageMessageButton() {
    double size = deviceHeight * 0.04;
    return Container(
      height: size,
      width: size,
      child: FloatingActionButton(
        onPressed: () {
          chatPageProvider.sendImageMessage();
        },
        child: Icon(Icons.camera_enhance),
        backgroundColor: Color.fromRGBO(0, 28, 218, 1),
      ),
    );
  }
}
