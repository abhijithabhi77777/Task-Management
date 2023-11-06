import 'dart:developer';

import 'package:get/get.dart';
import 'package:task_management_web_app/models/project_count_response.dart';
import 'package:task_management_web_app/models/staff_count_response.dart';
import 'package:task_management_web_app/utils/globals.dart' as globals;

import '../../api/api_manager.dart';
import '../../models/login_response_model.dart';

class HomeScreenController extends GetxController {

  LoginResponseModel? _loginResponseModel;
  StaffCountResponse? _staffCountResponse;
  ProjectCountResponse? _projectCountResponse;
  RxInt staffCount = 0.obs;
  RxInt projectCount = 0.obs;

  Future<void> currentStaffCount() async {
    _staffCountResponse = await APIManager.getStaffCount();

    staffCount.value = _staffCountResponse!.totalStaffCount;
    print(staffCount.value);
  }

  Future<void> allProjectCount() async {
    _projectCountResponse = await APIManager.getProjectCount();

    projectCount.value = _projectCountResponse!.totalProjectCount;
    print(staffCount.value);
  }
}
