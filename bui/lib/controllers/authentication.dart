import 'dart:convert';

import 'package:bui/constants/constants.dart';
import 'package:bui/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AuthenticationController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;
  final box = GetStorage();

  Future register({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'name': name,
        'username': username,
        'email': email,
        'password': password,
      };
      var response = await http.post(
        Uri.parse(url + 'register'), // Use string interpolation directly
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );
      if (response.statusCode == 201) {
        isLoading.value = false;
        token.value = json.decode(response.body)['token'];
        box.write('token', token.value);
      } else {
        isLoading.value = false;
        debugPrint(response.body);

        var responseData = json.decode(response.body);
        Get.snackbar(
          'Error', // Title
          responseData['message'] ?? 'Unknown error occurred',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error', // Title
        'An unexpected error occurred: $e', // Show the error message
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
      print(e);
    }
  }

  Future login({
    required String username,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'username': username,
        'password': password,
      };
      var response = await http.post(
        Uri.parse(url + 'login'), // Use string interpolation directly
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        var responseBody = json.decode(response.body);
        token.value = responseBody['token'];
        var userName = responseBody['user']
            ['name']; // Assuming the username is in the 'name' field
        box.write('token', token.value);
        box.write('username', userName); // Storing the username

        print(
            'Logged in user: $userName'); // Debug print to confirm the username is captured

        Get.offAll(() => HomePage()); // Navigate to the HomePage
      } else {
        isLoading.value = false;
        debugPrint(response.body);

        var responseData = json.decode(response.body);
        Get.snackbar(
          'Error', // Title
          responseData['message'] ?? 'Unknown error occurred',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error', // Title
        'An unexpected error occurred: $e', // Show the error message
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
      print(e);
    }
  }
}
