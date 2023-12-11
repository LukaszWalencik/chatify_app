import 'dart:convert';

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

  factory ChatUser.fromJSON(Map<String, dynamic> json) {
    return ChatUser(
        uid: json['uid'],
        name: json['name'],
        email: json['email'],
        imageURL: json['image'],
        lastActive: json['last_active'].toDate());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'image': imageURL,
      'last_active': lastActive
    };
  }

  String lastDayActive() {
    return '${lastActive.month}/${lastActive.day}/${lastActive.year}';
  }
}
