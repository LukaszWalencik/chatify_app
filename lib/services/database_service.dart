// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

const String USER_COLLECTION = 'Users';
const String CHAT_COLLECTION = 'Chats';
const String MESSAGES_COLLECTION = 'Messages';

class DatabaseService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getUser(String uid) {
    return db.collection(USER_COLLECTION).doc(uid).get();
  }

  Future<void> updateUserLastSeenTime(String uid) async {
    try {
      await db.collection(USER_COLLECTION).doc(uid).update({
        'last_active': DateTime.now().toUtc(),
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> createUser(
      String uid, String email, String name, String imageURL) async {
    try {
      await db.collection(USER_COLLECTION).doc(uid).set({
        'email': email,
        'image': imageURL,
        'last_active': DateTime.now().toUtc(),
        'name': name
      });
      print('Success registration');
    } catch (e) {
      print(e);
    }
  }

  Stream<QuerySnapshot> getChatsForUser(String uid) {
    return db
        .collection(CHAT_COLLECTION)
        .where('members', arrayContains: uid)
        .snapshots();
  }

  Future<QuerySnapshot> getLastMessageForChat(String chatID) {
    return db
        .collection(MESSAGES_COLLECTION)
        .doc(chatID)
        .collection(MESSAGES_COLLECTION)
        .orderBy('sent_time', descending: true)
        .limit(1)
        .get();
  }
}
