import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../view/home_page/home_page.dart';


class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var hidePassword = true.obs;
  var rememberMe = false.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadRememberedUser();
  }

  Future<void> _saveUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();

    if (rememberMe.value) {
      await prefs.setString('email', emailController.text);
      await prefs.setString('password', passwordController.text);
      await prefs.setBool('rememberMe', true);
      prefs.getInt('user_id');
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
      await prefs.setBool('rememberMe', false);
    }
  }

  Future<void> _loadRememberedUser() async {
    final prefs = await SharedPreferences.getInstance();
    rememberMe.value = prefs.getBool('rememberMe') ?? false;
    if (rememberMe.value) {
      emailController.text = prefs.getString('email') ?? '';
      passwordController.text = prefs.getString('password') ?? '';
    }
  }

  Future<void> emailAndPasswordLogIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email ve şifre alanları boş bırakılamaz.",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;

    final url = Uri.parse('http:/your-api-address'); // API URL
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        // Giriş başarılı
        final responseData = json.decode(response.body);
        final userId = responseData['user_id'];
        // SharedPreferences'a kaydediyoruz
        final prefs2 = await SharedPreferences.getInstance();
        await prefs2.setInt('user_id', userId);
        await _saveUserCredentials();

        Get.snackbar(
          "Success",
          "Giriş başarılı!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Ana sayfaya yönlendir
        Get.offAll(() => const HomePage(title: 'Ana Sayfa',));
      } else if (response.statusCode == 401) {
        // Hatalı kullanıcı bilgisi
        Get.snackbar(
          "Error",
          "Email veya şifre hatalı!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        // Diğer durumlar
        Get.snackbar(
          "Error",
          "Bir hata oluştu: ${response.reasonPhrase}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Sunucuya bağlanılamadı: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
