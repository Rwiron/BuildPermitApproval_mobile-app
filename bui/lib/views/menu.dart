import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:bui/models/menu_item.dart';

class MenuItems {
  //static const payment = MenuItem('Feedback ', Icons.feedback_outlined);
  static const promos = MenuItem('Home', Icons.home);
  static const notifications = MenuItem('Ask Permit', Icons.document_scanner);
  static const about = MenuItem('Doc Status', Icons.info_outline);
  static const help = MenuItem('Help', Icons.help);
  static const rateus = MenuItem('Profile', Icons.verified_user_rounded);

  static const all = <MenuItem>[
    promos,
    notifications,
    about,
    help,
    rateus,
    //payment,
  ];
}
class Menupage extends StatelessWidget {
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;

  const Menupage(
      {super.key, required this.currentItem, required this.onSelectedItem});

  @override
  Widget build(BuildContext context) => Theme(
        data: ThemeData.dark(),
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Spacer(),
              ...MenuItems.all.map(buildMenuItem).toList(),
              Spacer(
                flex: 2,
              ),
            ],
          )),
        ),
      );

  Widget buildMenuItem(MenuItem item) => ListTileTheme(
        selectedColor: Colors.white38,
        child: ListTile(
          selectedTileColor: Colors.white38,
          selected: currentItem == item,
          minLeadingWidth: 20,
          leading: Icon(item.icon),
          title: Text(item.title),
          onTap: () => onSelectedItem(item),
        ),
      );
}
