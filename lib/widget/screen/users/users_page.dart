import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_learning/model/user/user.dart';
import 'package:firestore_learning/routing/app_router.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'AllUsersRoute')
class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final fs = FirebaseFirestore.instance;

  late CollectionReference<Map<String, dynamic>> userCollection;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> users = [];

  _UsersPageState() {
    userCollection = fs.collection('users');
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    userCollection.snapshots().listen((event) {
      setState(() => users = event.docs);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        var doc = users[index];
        var id = doc.id;
        var user = User.fromJson(doc.data());
        return ListTile(
          title: TextButton(
            onPressed: () {
              context.router.navigate(EditUserRoute(id: doc.id, user: user));
            },
            child: Text(user.email),
          ),
          trailing: IconButton(
            onPressed: () => userCollection.doc(id).delete(),
            icon: const Icon(Icons.delete),
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: users.length,
    );
  }
}

class UserItem extends StatelessWidget {
  const UserItem({required this.id, required this.user, super.key});

  final String id;
  final User user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextButton(
              onPressed: () {
                context.router.navigate(EditUserRoute(id: id, user: user));
              },
              child: Text(user.email),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              FirebaseFirestore.instance.collection('users').doc(id).delete();
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
