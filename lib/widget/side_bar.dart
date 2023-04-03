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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  var router =
                      context.innerRouterOf<StackRouter>(UsersRoute.name)!;
                  router.replace(const AllUsersRoute());
                },
                child: const Text('All users'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  var router =
                      context.innerRouterOf<StackRouter>(UsersRoute.name)!;
                  router.replace(const CreateUserRoute());
                },
                child: const Text('Create user'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
