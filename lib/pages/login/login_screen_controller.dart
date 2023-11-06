import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_web_app/api/api_manager.dart';
import 'package:task_management_web_app/models/login_response_model.dart';
import 'package:task_management_web_app/pages/home/home_screen.dart';
import 'package:task_management_web_app/utils/globals.dart' as globals;

class LoginScreenController extends GetxController {
  LoginResponseModel? _loginResponseModel;

  final isLoading = false.obs;
  final credentials = true.obs;
  final emailValid = true.obs;

  void isEmailValid(String text) {
    isLoading.value = true;
    // Regular expression for email validation
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (emailRegex.hasMatch(text)) {
      emailValid.value = true;
    } else {
      emailValid.value = false;
    }
    update();
  }

  Future<void> isCredentialValid(String mailId, String password) async {
    try {
      _loginResponseModel = await APIManager.getLogin(mailId, password);

      if (_loginResponseModel is String &&
          _loginResponseModel == "Invalid credentials") {
        // Handle the "Invalid credentials" case
      } else if (_loginResponseModel is LoginResponseModel) {
        // Handle the successful login case
        globals.loginName = _loginResponseModel!.staffName;
        globals.loginPosition = _loginResponseModel!.position;
        globals.avatarName = _loginResponseModel!.avatarId;
        Get.to(const HomeScreen());
        isLoading.value = false;
        Get.snackbar(
          "Login successful",
          "",
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      log(e.toString());
      print('Error98988: $e');
      credentials.value = false;
      isLoading.value = false;
    }
  }
}
