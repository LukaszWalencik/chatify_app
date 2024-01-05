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

  factory ChatMessage.fromJSON(Map<String, dynamic> json) {
    MessageType messageType;
    switch (json['type']) {
      case 'text':
        messageType = MessageType.TEXT;
        break;
      case 'image':
        messageType = MessageType.IMAGE;
        break;
      default:
        messageType = MessageType.UNKNOWN;
    }
    return ChatMessage(
        senderID: json['sender_id'],
        type: messageType,
        content: json['content'],
        sentTime: json['date_time'].toDate());
  }
}
