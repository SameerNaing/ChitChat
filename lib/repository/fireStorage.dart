import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FireStorage {
  Reference _storageReference;

  String createProfileReference(String userId, String uniqueId) {
    String storePath = 'ProfileImages/$userId/$uniqueId';
    _storageReference = FirebaseStorage.instance.ref().child(storePath);
    return storePath;
  }

  String createImageMessageReference(String uniqueId) {
    String storePath = 'ImageMessagePath/$uniqueId';
    _storageReference = FirebaseStorage.instance.ref().child(storePath);
    return storePath;
  }

  String createImageUploadReference(String userId, String uniqueId) {
    String storePath = 'UserUploadImages/$userId/$uniqueId';
    _storageReference = FirebaseStorage.instance.ref().child(storePath);
    return storePath;
  }

  openExistingPath(String path) {
    _storageReference = FirebaseStorage.instance.ref().child(path);
  }

  UploadTask uploadImage(File imageFile) {
    UploadTask task = _storageReference.putFile(imageFile);
    return task;
  }

  Future<String> downloadUrl() async {
    return await _storageReference.getDownloadURL();
  }

  deleteImage() {
    _storageReference.delete();
  }
}
