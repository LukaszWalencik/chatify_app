// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

// ignore: constant_identifier_names
const String USER_COLLECTION = 'Users';

class CloudStorageService {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String?> saveUserImageToStorage(String uid, PlatformFile file) async {
    try {
      Reference reference =
          storage.ref().child('images/users/$uid/profile.${file.extension}');
      UploadTask uploadTask = reference.putFile(File(file.path!));
      return await uploadTask.then((result) => result.ref.getDownloadURL());
    } catch (e) {
      print(e);
    }
  }

  Future<String?> saveChatImageToStorage(
      String chatID, String userID, PlatformFile file) async {
    try {
      Reference reference = storage.ref().child(
          'images/chats/$chatID/${userID}_${Timestamp.now().millisecondsSinceEpoch}.${file.extension}');
      UploadTask uploadTask = reference.putFile(
        File(file.path!),
      );
      return uploadTask.then((result) => result.ref.getDownloadURL());
    } catch (e) {
      print(e);
    }
  }
}
