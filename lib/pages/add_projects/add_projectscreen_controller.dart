import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_web_app/api/api_manager.dart';
import 'package:task_management_web_app/models/project_added_response.dart';

class AddProjectScreenController extends GetxController {
  ProjectAddedResponse? _ProjectAddedResponse;

  Future<void> isNewProject(
      String nameOfClient, String nameOfProject, String? description) async {
    _ProjectAddedResponse =
        await APIManager.addProject(nameOfClient, nameOfProject, description);
    if (_ProjectAddedResponse?.message == "new project created successfully") {
      Get.snackbar(
        "Project added successfully",
        "",
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
      );
      Get.back;
    }
  }
}
