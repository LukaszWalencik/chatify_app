import 'package:firebase_storage/firebase_storage.dart';

// ignore: constant_identifier_names
const String USER_COLLECTION = 'Users';

class CloudStorageService {
  final FirebaseStorage storage = FirebaseStorage.instance;
}
