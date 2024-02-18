import 'package:bui/views/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class RequestPermit extends StatelessWidget {
  const RequestPermit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 10, 188, 242),
        title: const Text('Feed Page'),
        //leading: MenuWigdet(),
      ),
    );
  }
}
