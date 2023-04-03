import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firestore_learning/model/entity/user_entity.dart';
import 'package:firestore_learning/model/image/image_entity.dart';
import 'package:firestore_learning/model/user/user.dart';
import 'package:firestore_learning/storages/store.dart';

class UserStore extends Store<UserModel> {
  UserStore() : super(collectionName: 'users');

  final avatarStorage = FirebaseStorage.instance.ref().child('avatars');

  @override
  Future add({required UserModel data}) async {
    var user = data.user;
    if (data.image != null) {
      var file = File(data.image!.path!);
      var name = '${DateTime.now().toUtc()}.jpg';
      var avatarRef = avatarStorage.child(name);
      avatarRef.putFile(file);
      var url = await avatarRef.getDownloadURL();
      user = user.copyWith(avatar: ImageEntity(name: name, url: url));
    }

    collection.add(user.toJson());
  }

  @override
  Future delete({required String id}) async {
    var docRef = collection.doc(id);
    var doc = await docRef.get();
    var user = User.fromJson(doc.data()!);
    if (user.avatar != null) {
      avatarStorage.child(user.avatar!.name).delete();
    }
    docRef.delete();
  }

  @override
  Future edit({required String id, required UserModel data}) async {
    var user = data.user;
    if (data.image != null) {
      var file = File(data.image!.path!);
      var name = '${DateTime.now().toUtc()}.jpg';
      var avatarRef = avatarStorage.child(name);

      avatarRef.putFile(file);
      var url = await avatarRef.getDownloadURL();
      user = user.copyWith(avatar: ImageEntity(name: name, url: url));
    } else if (data.user.avatar != null) {
      user = user.copyWith(avatar: null);
      avatarStorage.child(user.avatar!.name).delete();
    }

    collection.doc(id).update(user.toJson());
  }
}
