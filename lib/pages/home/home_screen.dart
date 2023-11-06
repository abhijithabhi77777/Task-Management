import 'package:flutter/material.dart';
import 'package:flutterwebapp_reload_detector/flutterwebapp_reload_detector.dart';
import 'package:get/get.dart';
import 'package:task_management_web_app/Widgets/navbar.dart';
import 'package:task_management_web_app/pages/home/home_screen_controller.dart';
import 'package:task_management_web_app/pages/login/login_screen_controller.dart';
import 'package:task_management_web_app/utils/constants.dart';
import 'package:task_management_web_app/utils/globals.dart' as globals;

import '../../Widgets/data_table/data_table.dart';
import '../../Widgets/home_navbar/home_navbar.dart';
import '../../Widgets/loading_spinner.dart';
import '../../Widgets/logoutbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenController homeScreenController = HomeScreenController();
  LoginScreenController homeLoginController = LoginScreenController();

  @override
  void initState() {
    WebAppReloadDetector.onReload(() {
      print('Web Page Reloaded');
    });

    homeScreenController.currentStaffCount();
    homeScreenController.allProjectCount();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenwidth = MediaQuery.of(context).size.width;
    screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
          child: Obx(
        () => Column(
          children: [
            const logOutBar(),
            NavBar(
                loginName: globals.loginName,
                loginPosition: globals.loginPosition,
                countStaff: homeScreenController.staffCount.value,
                countProject: homeScreenController.projectCount.value),
            HomeNavBar(),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal, child: DataTableDemo()),
          ],
        ),
      )),
    );
  }
}
