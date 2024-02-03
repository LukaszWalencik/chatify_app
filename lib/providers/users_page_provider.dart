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
  }
  @override
  void dispose() {
    super.dispose();
  }
}
