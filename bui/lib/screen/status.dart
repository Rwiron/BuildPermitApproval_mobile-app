import 'package:bui/views/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class Status extends StatelessWidget {
  const Status({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(218, 1, 53, 175),
        title: const Text('Welcome to Building Request '),
        //leading: MenuWigdet(),
      ),
    );
  }
}
