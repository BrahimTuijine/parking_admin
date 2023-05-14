import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pfe_parking_admin/screens/dashboard/app_scaffold.dart';
import 'package:pfe_parking_admin/screens/login/normal_login.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/normalLogin',
    routes: [
      GoRoute(
        path: '/normalLogin',
        builder: (BuildContext context, GoRouterState state) => NormalLogin(),
      ),
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) {
          return AppScaffold(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            path: '/parkings',
            builder: (BuildContext context, GoRouterState state) {
              return const Center(child: Text('parkings'));
            },
          ),
          GoRoute(
            path: '/users',
            builder: (BuildContext context, GoRouterState state) {
              return const Center(child: Text('users'));
            },
          ),
        ],
      ),
    ],
  );
}
