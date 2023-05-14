import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  void onTap(int value) {
    switch (value) {
      case 1:
        return context.go('/users');
      default:
        return context.go('/parkings');
    }
  }

  int _calculateSelectedIndex(BuildContext context) {
    final GoRouter route = GoRouter.of(context);
    final String location = route.location;
    if (location.startsWith('/parkings')) {
      return 0;
    }

    if (location.startsWith('/users')) {
      return 1;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widget.child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        currentIndex: _calculateSelectedIndex(context),
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        elevation: 1,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Parkings'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Users'),
        ],
      ),
    );
  }
}
