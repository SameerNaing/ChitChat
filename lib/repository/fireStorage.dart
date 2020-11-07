import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FireStorage {
  StorageReference _storageReference;

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

  Future<String> uploadImage(File imageFile) async {
    StorageUploadTask _task = _storageReference.putFile(imageFile);
    String url = await (await _task.onComplete).ref.getDownloadURL();
    return url;
  }

  deleteImage() {
    _storageReference.delete();
  }
}
