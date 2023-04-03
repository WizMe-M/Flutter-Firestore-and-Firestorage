import 'package:auto_route/auto_route.dart';
import 'package:firestore_learning/routing/app_router.dart';
import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('All users'),
                onTap: () {
                  var router =
                      context.innerRouterOf<StackRouter>(UsersRoute.name)!;
                  router.replace(const AllUsersRoute());
                },
              ),
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text('Create new user'),
                onTap: () {
                  var router =
                      context.innerRouterOf<StackRouter>(UsersRoute.name)!;
                  router.replace(const CreateUserRoute());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
