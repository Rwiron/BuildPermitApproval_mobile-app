import 'package:bui/views/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 2, 194, 8),
        title: const Text('Profile Page'),
        //leading: MenuWigdet(),
      ),
    );
  }
}
