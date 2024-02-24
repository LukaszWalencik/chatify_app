import 'package:chatify_app/models/chat.dart';
import 'package:chatify_app/models/chat_user.dart';
import 'package:chatify_app/pages/chat_page.dart';
import 'package:chatify_app/providers/authentication_provider.dart';
import 'package:chatify_app/services/database_service.dart';
import 'package:chatify_app/services/navigation_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class UsersPageProvider extends ChangeNotifier {
  AuthenticationProvieder authenticationProvieder;
  late DatabaseService databaseService;
  late NavigationService navigationService;

  List<ChatUser>? chatUsers;
  late List<ChatUser> selectedUser;

  List<ChatUser> get selectedUsers {
    return selectedUser;
  }

  UsersPageProvider(this.authenticationProvieder) {
    selectedUser = [];
    databaseService = GetIt.instance.get<DatabaseService>();
    navigationService = GetIt.instance.get<NavigationService>();
    getUsers();
  }
  @override
  void dispose() {
    super.dispose();
  }

  void getUsers({String? name}) async {
    selectedUser = [];
    try {
      databaseService.getUsers(name: name).then(
        (snapshot) {
          chatUsers = snapshot.docs.map(
            (doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              data['uid'] = doc.id;
              return ChatUser.fromJSON(data);
            },
          ).toList();
        },
      );
    } catch (e) {
      print('Error getting users');
      print(e);
    }
  }

  void updateSelectedUsers(ChatUser user) {
    if (selectedUser.contains(user)) {
      selectedUser.remove(user);
    } else {
      selectedUser.add(user);
    }
    notifyListeners();
  }

  void createChat() async {
    try {
      //Create chat
      List<String> membersID = selectedUsers.map((user) => user.uid).toList();
      membersID.add(authenticationProvieder.chatUser.uid);
      bool isGroup = selectedUsers.length > 1;
      DocumentReference? doc = await databaseService.createChat(
        {'is_group': isGroup, 'is_acivity': false, 'members': membersID},
      );
      //Navigate to Chat Page
      List<ChatUser> members = [];
      for (var uid in membersID) {
        DocumentSnapshot userSnapshot = await databaseService.getUser(uid);
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        userData['uid'] = userSnapshot.id;
        members.add(
          ChatUser.fromJSON(userData),
        );
        ChatPage chatPage = ChatPage(
          chat: Chat(
            uid: doc!.id,
            currentUserUid: authenticationProvieder.chatUser.uid,
            activity: false,
            group: isGroup,
            members: members,
            messages: [],
          ),
        );
        selectedUser = [];
        notifyListeners();
        navigationService.navigatorToPage(chatPage);
      }
    } catch (e) {
      print('Error creating chat');
      print(e);
    }
  }
}
