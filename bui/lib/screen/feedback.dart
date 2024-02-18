import 'package:bui/constants/constants.dart';
import 'package:bui/views/widgets/menu_widget.dart';
import 'package:bui/views/widgets/permitnav.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FeedStatus extends StatefulWidget {
  const FeedStatus({Key? key}) : super(key: key);

  @override
  _FeedStatusState createState() => _FeedStatusState();
}

class _FeedStatusState extends State<FeedStatus> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _landUpiController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _sectorController = TextEditingController();
  final TextEditingController _cellController = TextEditingController();

  @override
  void dispose() {
    _landUpiController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _provinceController.dispose();
    _districtController.dispose();
    _sectorController.dispose();
    _cellController.dispose();
    super.dispose();
  }

  Future<void> submitRequest() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );

      // Retrieve the token from GetStorage
      final box = GetStorage();
      final token = box.read('token');

      // Ensure the token exists
      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unauthorized: Please login again.')),
        );
        return;
      }

      var payload = {
        'land_upi_number': _landUpiController.text,
        'description': _descriptionController.text,
        'location': _locationController.text,
        'province': _provinceController.text,
        'district': _districtController.text,
        'sector': _sectorController.text,
        'cell': _cellController.text,
        'status':
            'pending', // Assuming the status is set by default to 'pending'
      };

      // TODO: Replace with your actual endpoint URL and add authorization as needed
      String endpoint = url + 'feed/store';

      try {
        var response = await http.post(
          Uri.parse(endpoint),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token', // Including the token here
          },
          body: payload,
        );

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Request submitted successfully!')),
          );
          // Clear the form fields
          _clearForm();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Failed to submit request: ${response.body}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error sending request: $e')),
        );
      }
    }
  }

  void _clearForm() {
    _landUpiController.clear();
    _descriptionController.clear();
    _locationController.clear();
    _provinceController.clear();
    _districtController.clear();
    _sectorController.clear();
    _cellController.clear();
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
      appBar: CustomAppBars(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _landUpiController,
                decoration: _buildInputDecoration(
                  label: 'Land UPI Number',
                  icon: Icons.landslide,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the land UPI number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _locationController,
                decoration: _buildInputDecoration(
                  label: 'Location',
                  icon: Icons.my_location_outlined,
                ),
                //icon: Icons.lock_outline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the location';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _provinceController,
                decoration: _buildInputDecoration(
                  label: 'Province',
                  icon: Icons.location_city,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the province';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _districtController,
                decoration: _buildInputDecoration(
                  label: 'District',
                  icon: Icons.house_siding_outlined,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the district';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _sectorController,
                decoration: _buildInputDecoration(
                  label: 'Sector',
                  icon: Icons.map_outlined,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the sector';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _cellController,
                decoration: _buildInputDecoration(
                  label: 'Cell',
                  icon: Icons.insert_chart_outlined_outlined,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the cell';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint:
                      true, // Ensures the label is aligned at the top-left, similar to a textarea
                  border:
                      OutlineInputBorder(), // Provides a border around the text field
                  hintText:
                      "Enter your description here...", // Placeholder text
                  // Add padding inside the text field for the text area effect
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                ),
                maxLines:
                    5, // Sets initial visible lines to 5, making it look bigger
                keyboardType:
                    TextInputType.multiline, // Allows for multiline input
                textInputAction: TextInputAction
                    .newline, // Adds a new line on the soft keyboard for multiline input
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: submitRequest,
                child: const Text(
                  'Submit Request',
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
