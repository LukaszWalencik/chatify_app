// ignore_for_file: avoid_print

import 'package:chatify_app/models/chat_user.dart';
import 'package:chatify_app/services/database_service.dart';
import 'package:chatify_app/services/navigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AuthenticationProvieder extends ChangeNotifier {
  late final FirebaseAuth auth;
  late final NavigationService navigationService;
  late final DatabaseService databaseService;
  late ChatUser chatUser;

  AuthenticationProvieder() {
    auth = FirebaseAuth.instance;
    navigationService = GetIt.instance.get<NavigationService>();
    databaseService = GetIt.instance.get<DatabaseService>();
    auth.authStateChanges().listen((user) {
      if (user != null) {
        print('Logged in');
        databaseService.updateUserLastSeenTime(user.uid);
        databaseService.getUser(user.uid).then((snapshot) {
          Map<String, dynamic> userData =
              snapshot.data()! as Map<String, dynamic>;
          chatUser = ChatUser.fromJSON({
            'uid': user.uid,
            'name': userData['name'],
            'email': userData['email'],
            'last_active': userData['last_active'],
            'image': userData['image'],
          });
          print(chatUser.toMap());
          navigationService.removeAndNavigateToRoute('/home');
        });
      } else {
        print('Not authenticated');
        navigationService.removeAndNavigateToRoute('/login');
      }
    });
  }
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseException {
      print('Error when try to Firebase login');
    } catch (e) {
      print(e);
    }
  }

  Future<String?> registerUserEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user!.uid;
    } on FirebaseAuthException {
      print('Error registering user.');
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
