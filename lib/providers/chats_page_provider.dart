// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:chatify_app/models/chat_message.dart';
import 'package:chatify_app/models/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:chatify_app/models/chat.dart';
import 'package:chatify_app/providers/authentication_provider.dart';
import 'package:chatify_app/services/database_service.dart';
import 'package:get_it/get_it.dart';

class ChatsPageProvider extends ChangeNotifier {
  AuthenticationProvieder auth;
  late DatabaseService databaseService;
  List<Chat>? chats;
  late StreamSubscription chatStream;
  ChatsPageProvider(
    this.auth,
  ) {
    databaseService = GetIt.instance.get<DatabaseService>();
    getChats();
  }

  @override
  void dispose() {
    chatStream.cancel();

    super.dispose();
  }

  void getChats() async {
    try {
      chatStream = databaseService.getChatsForUser(auth.chatUser.uid).listen(
        (snapshot) async {
          chats = await Future.wait(
            snapshot.docs.map(
              (doc) async {
                Map<String, dynamic> chatData =
                    doc.data() as Map<String, dynamic>;
                //Get User in Chat
                List<ChatUser> members = [];
                for (var uid in chatData['members']) {
                  DocumentSnapshot userSnapshot =
                      await databaseService.getUser(uid);
                  Map<String, dynamic> userData =
                      userSnapshot.data() as Map<String, dynamic>;
                  userData['uid'] = userSnapshot.id;
                  members.add(ChatUser.fromJSON(userData));
                }
                //Get Last Message For Chat
                List<ChatMessage> messages = [];
                QuerySnapshot chatMessage =
                    await databaseService.getLastMessageForChat(doc.id);
                if (chatMessage.docs.isNotEmpty) {
                  Map<String, dynamic> messageData =
                      chatMessage.docs.first.data()! as Map<String, dynamic>;
                  ChatMessage message = ChatMessage.fromJSON(messageData);
                  messages.add(message);
                }

                //Return Chat Instance
                return Chat(
                    uid: doc.id,
                    currentUserUid: auth.chatUser.uid,
                    activity: chatData['is_activity'],
                    group: chatData['is_group'],
                    members: members,
                    messages: messages);
              },
            ).toList(),
          );
          notifyListeners();
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
