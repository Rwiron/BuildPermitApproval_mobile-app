import 'package:flutter/material.dart';

class CustomAppBars extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20)), // Apply rounded corners to the bottom
      child: AppBar(
        backgroundColor: Color.fromARGB(255, 24, 17, 120),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 24, 17, 120),
                Color.fromARGB(255, 24, 17, 120),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          'Apply for Permit',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white, // Set the text color to white
          ),
        ),
        centerTitle: true,
        elevation: 0, // Remove shadow
        actions: [
          IconButton(
            icon:
                Icon(Icons.settings_applications_rounded, color: Colors.white),
            onPressed: () {
              // Action for the notification icon
            },
          ),
        ],
      ),
    );
  }
}
