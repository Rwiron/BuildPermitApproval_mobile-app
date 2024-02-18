import 'package:flutter/material.dart';


class Help extends StatelessWidget {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 59, 150, 255),
        title: const Text('Helps Page'),
        //leading: MenuWigdet(),
      ),
    );
  }
}
