import 'package:chatify_app/providers/authentication_provider.dart';
import 'package:chatify_app/widgets/custom_list_view_tiles.dart';
import 'package:chatify_app/widgets/top_bar.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    auth = Provider.of<AuthenticationProvieder>(context);
    return buildUI();
  }

  Widget buildUI() {
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
  }

  Widget chatList() {
    return Expanded(child: chatTile());
  }

  Widget chatTile() {
    return CustomListViewTileWithActivity(
        height: deviceHeight * 0.10,
        title: 'Wasia',
        subtitle: 'Hello',
        image:
            'https://www.flaticon.com/free-icon/chat_684849?term=chat&page=1&position=10&origin=tag&related_id=684849',
        isActive: false,
        isActivity: false,
        onTap: () {});
  }
}
