import 'package:bui/views/widgets/custVa.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bui/constants/constants.dart'; // Ensure this points to your constants file correctly.

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final box = GetStorage();
    final token = box.read('token');
    final apiUrl =
        url + 'user/update-profile'; // Adjust with your actual endpoint

    Map<String, dynamic> payload = {
      'name': _nameController.text,
      'username': _usernameController.text,
      'email': _emailController.text,
    };
    if (_passwordController.text.isNotEmpty) {
      payload['password'] = _passwordController.text;
    }

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(payload),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile updated successfully')));
        // Optionally, update local storage or state with new user data
      } else {
        final error = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error updating profile: ${error['message']}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('An error occurred: $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  InputDecoration _buildInputDecoration(
      {required String label, required IconData icon}) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
      prefixIcon: Icon(icon),
      // Added filled properties to improve the aesthetics
      filled: true,
      fillColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar4(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 26),
                    TextFormField(
                      controller: _nameController,
                      decoration: _buildInputDecoration(
                        label: 'Name',
                        icon: Icons.person,
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Name cannot be empty' : null,
                    ),
                    SizedBox(height: 26),
                    TextFormField(
                      controller: _usernameController,
                      decoration: _buildInputDecoration(
                        label: 'Username',
                        icon: Icons.person_outline,
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Username cannot be empty' : null,
                    ),
                    SizedBox(height: 26),
                    TextFormField(
                      controller: _emailController,
                      decoration: _buildInputDecoration(
                        label: 'Email',
                        icon: Icons.email,
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Email cannot be empty' : null,
                    ),
                    SizedBox(height: 26),
                    TextFormField(
                      controller: _passwordController,
                      decoration: _buildInputDecoration(
                        label: 'New Password (leave blank to keep current)',
                        icon: Icons.lock_outline,
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 26),
                    ElevatedButton(
                      onPressed: _updateProfile,
                      child: const Text(
                        'Update Profile',
                        style: TextStyle(
                          fontSize: 18, // Adjust the font size as needed
                          fontWeight: FontWeight.bold, // Make the text bold
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(
                            255, 24, 17, 120), // Button background color
                        onPrimary: Colors
                            .white, // Button text color (when button is enabled)
                        onSurface: Colors.blueAccent.withOpacity(
                            0.5), // Button text color (when button is disabled)
                        padding: EdgeInsets.symmetric(
                            horizontal: 12, vertical: 16), // Button padding
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Button border radius
                        ),
                        elevation: 5, // Button elevation
                        shadowColor: Color.fromARGB(255, 24, 17, 120)
                            .withOpacity(0.5), // Shadow color
                      ), // more light required for the button 
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
