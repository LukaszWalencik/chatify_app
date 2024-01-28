// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:chatify_app/widgets/message_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:chatify_app/models/chat_message.dart';
import 'package:chatify_app/models/chat_user.dart';
import 'package:chatify_app/widgets/rounded_image.dart';

class CustomListViewTileWithActivity extends StatelessWidget {
  final double height;
  final String title;
  final String subtitle;
  final String image;
  final bool isActive;
  final bool isActivity;
  final Function onTap;
  const CustomListViewTileWithActivity({
    Key? key,
    required this.height,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.isActive,
    required this.isActivity,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () => onTap,
        minVerticalPadding: height * 0.20,
        leading: RoundedImageNetworkWithStatusIndicator(
            isActive: isActive, imagePath: image, size: height / 2),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: isActivity
            ? Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SpinKitThreeBounce(
                    color: Colors.white54,
                    size: height * 0.10,
                  )
                ],
              )
            : Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ));
  }
}

class CustomChatListViewTile extends StatelessWidget {
  final double width;
  final double height;
  final bool isOwnMessage;
  final ChatMessage chatMessage;
  final ChatUser chatUser;
  const CustomChatListViewTile({
    Key? key,
    required this.width,
    required this.height,
    required this.isOwnMessage,
    required this.chatMessage,
    required this.chatUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      width: width,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment:
            isOwnMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          !isOwnMessage
              ? RoundedImageNetwork(
                  imagePath: chatUser.imageURL, size: width * 0.04)
              : Container(),
          SizedBox(
            width: width * 0.05,
          ),
          chatMessage.type == MessageType.TEXT
              ? TextMessageBubble(
                  isOwnMessage: isOwnMessage,
                  message: chatMessage,
                  width: width,
                  height: height * 0.06)
              : ImageMessageBubble(
                  isOwnMessage: isOwnMessage,
                  chatMessage: chatMessage,
                  height: height * 0.30,
                  width: width * 0.55,
                )
        ],
      ),
    );
  }
}
