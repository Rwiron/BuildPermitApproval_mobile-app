import 'package:bui/screen/feedback.dart';
import 'package:bui/screen/requestPermit.dart';
import 'package:bui/views/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:bui/models/menu_item.dart';
import 'package:bui/views/widgets/drawermenu.dart';

// Import your screen widgets here
import 'package:bui/screen/help.dart';
import 'package:bui/screen/profile.dart';
import 'package:bui/screen/status.dart';
import 'package:bui/screen/user_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ZoomDrawerController _drawerController = ZoomDrawerController();
  MenuItem _currentItem =
      MenuItems.all.first; // Start with the first item as current

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: ZoomDrawer(
        controller: _drawerController,
        menuScreen: DrawerMenu(
          currentItem: _currentItem,
          onSelectedItem: (item) {
            setState(() {
              _currentItem = item;
              _drawerController.close!();
            });
          },
        ),
        mainScreen: Scaffold(
          appBar: AppBar(
            title: Text(_currentItem.title),
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => _drawerController.toggle!(),
            ),
          ),
          body: getScreen(),
        ),
        borderRadius: 24.0,
        showShadow: true,
        angle: -12.0,
        slideWidth: MediaQuery.of(context).size.width * 0.65,
      ),
    );
  }

  Widget getScreen() {
    switch (_currentItem) {
      // case MenuItems.payment:
      //   return const RequestPermit();
      case MenuItems.promos:
        return Status();
      case MenuItems.notifications:
        return FeedStatus(); // Assuming 'Feedback' corresponds to 'Notification' in your menu
      case MenuItems.help:
        return const Help();
      case MenuItems.about:
        return const Profile(); // Assuming 'About Us' corresponds to 'Profile' in your menu
      case MenuItems.rateus:
        return const UserHome();
      default:
        return const UserHome();
    }
  }
}
