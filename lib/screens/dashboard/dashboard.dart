import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Dashboard extends HookWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('dashboard'),
      ),
      body: Container(),
    );
  }
}
