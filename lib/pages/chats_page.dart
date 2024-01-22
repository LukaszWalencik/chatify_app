import 'package:chatify_app/models/chat.dart';
import 'package:chatify_app/models/chat_message.dart';
import 'package:chatify_app/models/chat_user.dart';
import 'package:chatify_app/providers/authentication_provider.dart';
import 'package:chatify_app/providers/chats_page_provider.dart';
import 'package:chatify_app/services/navigation_service.dart';
import 'package:chatify_app/widgets/custom_list_view_tiles.dart';
import 'package:chatify_app/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  late double deviceHeight;
  late double deviceWidth;
  late AuthenticationProvieder auth;
  late ChatsPageProvider chatPageProvider;
  late NavigationService navigationService;
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    auth = Provider.of<AuthenticationProvieder>(context);
    navigationService = GetIt.instance.get<NavigationService>();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatsPageProvider>(
            create: (_) => ChatsPageProvider(auth))
      ],
      child: buildUI(),
    );
  }

  Widget buildUI() {
    return Builder(builder: (context) {
      chatPageProvider = context.watch<ChatsPageProvider>();
      return Container(
        padding: EdgeInsets.symmetric(
            horizontal: deviceWidth * 0.03, vertical: deviceHeight * 0.02),
        height: deviceHeight * 0.98,
        width: deviceWidth * 0.97,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TopBar(
              barTitle: 'Chats',
              primaryAction: IconButton(
                  onPressed: () {
                    auth.logout();
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Color.fromRGBO(0, 82, 218, 1),
                  )),
            ),
            chatList(),
          ],
        ),
      );
    });
  }

  Widget chatList() {
    List<Chat>? chats = chatPageProvider.chats;
    return Expanded(
      child: (() {
        if (chats != null) {
          if (chats.isNotEmpty) {
            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                return chatTile(chats[index]);
              },
            );
          } else {
            return const Center(
              child: Text(
                'No Chats Found!',
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
      }()),
    );
  }

  Widget chatTile(Chat chat) {
    List<ChatUser> recepiens = chat.users();
    bool isActive = recepiens.any((element) => element.wasRecentlyActive());
    String subtitleText = '';
    if (chat.messages.isNotEmpty) {
      subtitleText = chat.messages.first.type != MessageType.TEXT
          ? 'Media Attachment'
          : chat.messages.first.content;
    }
    return CustomListViewTileWithActivity(
        height: deviceHeight * 0.10,
        title: chat.title(),
        subtitle: subtitleText,
        image: chat.imageURL(),
        isActive: isActive,
        isActivity: chat.activity,
        onTap: () {});
  }
}
