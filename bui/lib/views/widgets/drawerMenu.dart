import 'package:bui/models/menu_item.dart';
import 'package:bui/views/login_screen.dart';
import 'package:bui/views/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

class DrawerMenu extends StatelessWidget {
  final MenuItem currentItem;
  final Function(MenuItem) onSelectedItem;

  const DrawerMenu({
    Key? key,
    required this.currentItem,
    required this.onSelectedItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Adjust the color to match your design
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Spacer(),
            for (var item in MenuItems.all) buildMenuItem(item, context),
            Spacer(
              flex: 2,
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () => _logout(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(MenuItem item, BuildContext context) {
    final isSelected = currentItem == item;

    return ListTile(
      selected: isSelected,
      leading: Icon(item.icon, color: isSelected ? Colors.white : Colors.grey),
      title: Text(item.title,
          style: TextStyle(color: isSelected ? Colors.white : Colors.grey)),
      onTap: () => onSelectedItem(item),
    );
  }
}

void _logout(BuildContext context) {
  // Show logout confirmation dialog first
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Logout'),
        content: Text(
            'We are sad to see you leave us. Are you sure you want to log out?'),
        actions: <Widget>[
          TextButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context)
                  .pop(); // Dismiss the dialog but don't logout
            },
          ),
          TextButton(
            child: Text('Yes'),
            onPressed: () {
              // Clear user data from storage
              final box = GetStorage();
              box.erase();

              // Navigate to the login page
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginPage()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      );
    },
  );
}
