import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_learning/model/entity/user_entity.dart';
import 'package:firestore_learning/model/user/user.dart';
import 'package:firestore_learning/storages/store.dart';
import 'package:firestore_learning/storages/user_store.dart';
import 'package:firestore_learning/routing/app_router.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'AllUsersRoute')
class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final Store<UserModel> store = UserStore();

  List<QueryDocumentSnapshot<Map<String, dynamic>>> users = [];
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? subscription;

  Future<void> _initData() async {
    subscription = store.collection.snapshots().listen((event) {
      setState(() => users = event.docs);
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        var doc = users[index];
        var id = doc.id;
        var user = User.fromJson(doc.data());
        return ListTile(
          leading: SizedBox(
            width: 50,
            height: 50,
            child: user.avatar != null
                ? Image.network(user.avatar!.url)
                : const Placeholder(),
          ),
          title: TextButton(
            onPressed: () {
              context.router.navigate(EditUserRoute(id: doc.id, user: user));
            },
            child: Text(user.email),
          ),
          trailing: IconButton(
            onPressed: () {
              store.delete(id: id);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('User was deleted'),
                  duration: Duration(milliseconds: 300),
                ),
              );
            },
            icon: const Icon(Icons.delete),
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: users.length,
    );
  }
}
