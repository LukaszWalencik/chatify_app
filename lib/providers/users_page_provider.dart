import 'package:chatify_app/models/chat_user.dart';
import 'package:chatify_app/providers/authentication_provider.dart';
import 'package:chatify_app/services/database_service.dart';
import 'package:chatify_app/services/navigation_service.dart';
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
}
