import 'package:meta/meta.dart';

class DisplayMessageModel {
  String uid;
  String name;
  String profilPicUrl;
  String lastMessage;
  bool isNew;

  DisplayMessageModel({
    @required this.uid,
    @required this.name,
    @required this.profilPicUrl,
    @required this.lastMessage,
    @required this.isNew,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'name': this.name,
      'profilePicUrl': this.profilPicUrl,
      'lastMessage': this.lastMessage,
      'isNew': this.isNew,
    };
  }

  static DisplayMessageModel fromMap(Map<String, dynamic> doc) {
    return DisplayMessageModel(
      uid: doc['uid'],
      name: doc['name'],
      profilPicUrl: doc['profilePicUrl'],
      lastMessage: doc['lastMessage'],
      isNew: doc['isNew'],
    );
  }
}
