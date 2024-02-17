import 'package:bui/models/menu_item.dart';
import 'package:bui/views/menu.dart';
import 'package:bui/views/widgets/DrawerMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart'; // Update with the correct path to your DrawerMenu widget

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _drawerController = ZoomDrawerController();
  MenuItem _currentItem =
      MenuItems.payment; // Start with the first item as current

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(), // Use the dark theme for all child widgets
      child: ZoomDrawer(
        controller: _drawerController,
        //style: DrawerStyle.style1,
        menuScreen: DrawerMenu(
          currentItem: _currentItem,
          onSelectedItem: (item) {
            setState(() => _currentItem = item);
            _drawerController.close!();
            // Handle the page change: You can use a Navigator or a callback
          },
        ),
        mainScreen: Scaffold(
          appBar: AppBar(
            title: const Text('HomePage'),
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => _drawerController.toggle!(),
            ),
          ),
          body: Center(
            child:
                Text('Main content here'), // Placeholder for your main content
          ),
          backgroundColor: Colors.white, // Ensure the background color is black
        ),
        borderRadius: 24.0,
        showShadow: true,
        angle: -12.0,
        //backgroundColor: Colors.grey[300]!,
        slideWidth: MediaQuery.of(context).size.width * 0.65,
      ),
    );
  }
}
