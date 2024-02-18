import 'package:bui/models/menu_item.dart';
import 'package:bui/views/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

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
            )
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
