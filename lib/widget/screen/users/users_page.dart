import 'package:auto_route/annotations.dart';
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
  Map<String, User> users = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void activate() {
    super.activate();
    fetchData();
  }

  Future fetchData() async {
    var querySnapshot = await fs.collection('users').get();

    setState(() {
      users.clear();
      for (var doc in querySnapshot.docs) {
        users[doc.id] = User.fromJson(doc.data());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        var key = users.keys.elementAt(index);
        var user = users[key];
        return UserItem(
          id: key,
          user: user!,
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: TextButton(
          onPressed: () {
            context.router.navigate(EditUserRoute(id: id, user: user));
          },
          child: Text(user.email),
        ),
      ),
    );
  }
}
