// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:chatify_app/models/chat_message.dart';
import 'package:chatify_app/providers/authentication_provider.dart';
import 'package:chatify_app/services/cloud_storage_service.dart';
import 'package:chatify_app/services/database_service.dart';
import 'package:chatify_app/services/media_service.dart';
import 'package:chatify_app/services/navigation_service.dart';
import 'package:get_it/get_it.dart';

class ChatPageProvider extends ChangeNotifier {
  late DatabaseService databaseService;
  late CloudStorageService cloudStorageService;
  late MediaService mediaService;
  late NavigationService navigationService;
  late AuthenticationProvieder auth;
  ScrollController messagesListViewController;

  String chatID;
  List<ChatMessage>? messages;
  String? message;
  ChatPageProvider(
    this.auth,
    this.messagesListViewController,
    this.chatID,
  ) {
    databaseService = GetIt.instance.get<DatabaseService>();
    cloudStorageService = GetIt.instance.get<CloudStorageService>();
    mediaService = GetIt.instance.get<MediaService>();
    navigationService = GetIt.instance.get<NavigationService>();
  }
  String get mess {
    return mess;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
