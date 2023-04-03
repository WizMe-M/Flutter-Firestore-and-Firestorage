import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Store<T> {
  Store({required String collectionName}) {
    collection = FirebaseFirestore.instance.collection(collectionName);
  }

  late CollectionReference<Map<String, dynamic>> collection;

  Future add({required T data});

  Future edit({required String id, required T data});

  Future delete({required String id});
}
