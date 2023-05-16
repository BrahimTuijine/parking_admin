import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pfe_parking_admin/models/parking_data.dart';
import 'package:pfe_parking_admin/screens/airopors/airoport_list.dart';
import 'package:pfe_parking_admin/screens/dashboard/app_scaffold.dart';
import 'package:pfe_parking_admin/screens/login/normal_login.dart';
import 'package:pfe_parking_admin/screens/parkings/parking_list.dart';
import 'package:pfe_parking_admin/screens/users/users.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: FirebaseAuth.instance.currentUser?.uid == null
        ? '/normalLogin'
        : '/airoports',
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
            path: '/airoports',
            builder: (BuildContext context, GoRouterState state) {
              return const AiroportList();
            },
          ),
          GoRoute(
            path: '/users',
            builder: (BuildContext context, GoRouterState state) {
              return const Users();
            },
          ),
        ],
      ),
      GoRoute(
        path: '/parkings',
        builder: (BuildContext context, GoRouterState state) => ParkingList(
          parkingData: state.extra as ParkingData,
        ),
      ),
    ],
  );
}
