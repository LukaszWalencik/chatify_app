import 'package:chatify_app/models/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class TextMessageBubble extends StatelessWidget {
  final bool isOwnMessage;
  final ChatMessage message;
  final double width;
  final double height;
  const TextMessageBubble(
      {super.key,
      required this.isOwnMessage,
      required this.message,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    List<Color> colorSheme = isOwnMessage
        ? [
            const Color.fromRGBO(0, 136, 249, 1),
            const Color.fromRGBO(0, 82, 218, 1)
          ]
        : [
            const Color.fromRGBO(51, 49, 68, 1),
            const Color.fromRGBO(51, 49, 68, 1)
          ];
    return Container(
      height: height + (message.content.length / 20 * 6.0),
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
            colors: colorSheme,
            stops: const [0.30, 0.70],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.content,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          Text(
            timeago.format(message.sentTime),
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

class ImageMessageBubble extends StatelessWidget {
  final bool isOwnMessage;
  final ChatMessage chatMessage;
  final double height;
  final double width;

  const ImageMessageBubble(
      {super.key,
      required this.isOwnMessage,
      required this.chatMessage,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    List<Color> colorSheme = isOwnMessage
        ? [
            const Color.fromRGBO(0, 136, 249, 1),
            const Color.fromRGBO(0, 82, 218, 1)
          ]
        : [
            const Color.fromRGBO(51, 49, 68, 1),
            const Color.fromRGBO(51, 49, 68, 1)
          ];
    DecorationImage decorationImage = DecorationImage(
        image: NetworkImage(chatMessage.content), fit: BoxFit.cover);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.03,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
            colors: colorSheme,
            stops: const [0.30, 0.70],
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: decorationImage),
          ),
          SizedBox(height: height * 0.02),
          Text(
            timeago.format(chatMessage.sentTime),
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
