import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user_model.dart';

class SignupController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> registerUser() async {
    if (!validateInputs()) return;

    isLoading.value = true;

    final user = User(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    final url = Uri.parse("http:/your-api-address"); // API URL

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(user.toJson()),
      );

      if (response.statusCode == 201) {
        if (kDebugMode) {
          print("User registered successfully!");
        }

        Get.snackbar("Success", "Account created successfully!",
            snackPosition: SnackPosition.BOTTOM);
        //   Get.offAll(() => HomePage());
      } else {
        if (kDebugMode) {
          print("Error: ${response.body}");
        }
        Get.snackbar("Error", "Registration failed!",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception: $e");
      }
      Get.snackbar("Error", "Something went wrong!",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', userId);
  }

  bool validateInputs() {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar("Error", "All fields are required",
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar("Error", "Passwords do not match",
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    return true;
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
