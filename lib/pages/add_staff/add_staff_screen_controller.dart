import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_web_app/api/api_manager.dart';
import 'package:task_management_web_app/models/staff_created_response.dart';

class AddStaffScreenController extends GetxController {
  StaffCreatedResponse? _staffCreatedResponse;
  RxString atrName = ''.obs;

  void handleAvatarSelection(String selectedAvatar) {
    {
      atrName.value = selectedAvatar;
    }
  }

  Future<void> isNewStaff(
      String staffName,
      String mailId,
      String password,
      String position,
      String role,
      String employeeId,
      String employeeType,
      String atrName) async {
    _staffCreatedResponse = await APIManager.addStaff(staffName, mailId,
        password, position, role, employeeId, employeeType, atrName);
    print("adding");
    if (_staffCreatedResponse?.message == "Staff member created successfully") {
      Get.snackbar(
        "Staff adding successful",
        "",
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
      );
      Get.back;
    }
  }
}
