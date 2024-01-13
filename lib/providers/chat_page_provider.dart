// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:chatify_app/models/chat.dart';
import 'package:chatify_app/providers/authentication_provider.dart';
import 'package:chatify_app/services/database_service.dart';
import 'package:get_it/get_it.dart';

class ChatPageProvider extends ChangeNotifier {
  AuthenticationProvieder auth;
  late DatabaseService databaseService;
  List<Chat>? chats;
  late StreamSubscription chatStream;
  ChatPageProvider(
    this.auth,
  ) {
    databaseService = GetIt.instance.get<DatabaseService>();
  }

  @override
  void dispose() {
    chatStream.cancel();

    super.dispose();
  }
}
