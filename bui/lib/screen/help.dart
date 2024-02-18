import 'package:bui/views/widgets/helpnav.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  void _showContactSupport(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Contact us at 0780961542'),
      action: SnackBarAction(
        label: 'Copy',
        onPressed: () {
          Clipboard.setData(ClipboardData(text: "0780961542"));
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar3(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Image.asset(
              'assets/images/support.png', // Replace with your asset path
              height: 200, // Set the image height
              width: 200, // Set the image width
            ),
          ),
          SizedBox(height: 26.0),
          ListTile(
            leading: Icon(Icons.phone, color: Theme.of(context).primaryColor),
            title: Text('Contact Support'),
            onTap: () => _showContactSupport(context),
          ),
          SizedBox(height: 26.0),
          ExpansionTile(
            leading: Icon(Icons.book, color: Theme.of(context).primaryColor),
            title: Text('Terms & Conditions'),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'By using the Building Request Portal App, you agree to the following terms and conditions:\n\n'
                  '1. Usage: The app is intended for personal and non-commercial use only.\n\n'
                  '2. Content: You agree not to submit illegal content to the app, and acknowledge that you are responsible for the content you provide.\n\n'
                  '3. Privacy: We respect your privacy and commit to protecting your personal data. Refer to our Privacy Policy for more information.\n\n'
                  '4. Changes to Terms: We reserve the right to modify these terms at any time. Your continued use of the app constitutes your agreement to the new terms.\n\n'
                  '5. Contact: For any questions or concerns regarding these terms, please contact us at support@buildingrequestportal.com.\n\n'
                  'Thank you for choosing Building Request Portal!',
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
