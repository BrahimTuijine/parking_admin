import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Users extends HookWidget {
  const Users({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Container(),
    );
  }
}
