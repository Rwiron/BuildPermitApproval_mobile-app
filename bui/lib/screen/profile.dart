import 'package:bui/views/widgets/menu_widget.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lime,
        title: const Text('My Request Result'),
        //leading: MenuWigdet(),
      ),
    );
  }
}
