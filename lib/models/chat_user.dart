// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatUser {
  final String uid;
  final String name;
  final String email;
  final String imageURL;
  late DateTime lastActive;
  ChatUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.imageURL,
    required this.lastActive,
  });
}
