import 'package:auto_route/auto_route.dart';
import 'package:firestore_learning/widget/side_bar.dart';
import 'package:flutter/material.dart';

@RoutePage()
class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore'),
      ),
      drawer: const SideBar(),
      body: const AutoRouter(),
    );
  }
}
