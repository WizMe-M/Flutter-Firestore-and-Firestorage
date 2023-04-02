import 'package:auto_route/auto_route.dart';
import 'package:firestore_learning/widget/screen/users_screen.dart';
import 'package:firestore_learning/widget/screen/users/create_user_page.dart';
import 'package:firestore_learning/widget/screen/users/users_page.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  final List<AutoRoute> routes = [
    RedirectRoute(
      path: '/',
      redirectTo: '/users',
    ),
    AutoRoute(
      path: '/users',
      page: UsersRoute.page,
      children: [
        RedirectRoute(
          path: '',
          redirectTo: 'all',
        ),
        AutoRoute(
          path: 'all',
          page: AllUsersRoute.page,
        ),
        AutoRoute(
          path: 'create',
          page: CreateUserRoute.page,
        ),
      ],
    ),
  ];
}
