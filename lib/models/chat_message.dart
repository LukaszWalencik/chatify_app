// ignore_for_file: public_member_api_docs, sort_constructors_first

enum MessageType {
  TEXT,
  IMAGE,
  UNKNOWN,
}

class ChatMessage {
  final String senderID;
  final MessageType type;
  final String content;
  final DateTime sentTime;
  ChatMessage({
    required this.senderID,
    required this.type,
    required this.content,
    required this.sentTime,
  });
}
