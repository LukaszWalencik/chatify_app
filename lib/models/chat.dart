// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chatify_app/models/chat_message.dart';
import 'package:chatify_app/models/chat_user.dart';

class Chat {
  final String uid;
  final String currentUserUid;
  final bool activity;
  final bool group;
  final List<ChatUser> members;
  List<ChatMessage> messages;
  late final List<ChatUser> recepiens;
  Chat({
    required this.uid,
    required this.currentUserUid,
    required this.activity,
    required this.group,
    required this.members,
    required this.messages,
  }) {
    recepiens =
        members.where((member) => member.uid != currentUserUid).toList();
  }
  List<ChatUser> users() {
    return recepiens;
  }

  String title() {
    return !group
        ? recepiens.first.name
        : recepiens.map((user) => user.name).join(', ');
  }
}
