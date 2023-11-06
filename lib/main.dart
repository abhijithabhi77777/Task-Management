import 'dart:ui';

import 'package:cool_dropdown/controllers/dropdown_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_web_app/pages/add_projects/add_project_screen.dart';
import 'package:task_management_web_app/pages/add_projects/add_projectscreen_controller.dart';
import 'package:task_management_web_app/pages/add_staff/add_staff_screen.dart';
import 'package:task_management_web_app/pages/login/login_screen_controller.dart';
import 'package:task_management_web_app/utils/pallete.dart';

import 'Widgets/custom_dropdown/custom_dropdown_controller.dart';
import 'Widgets/data_table/data_table.dart';
import 'pages/home/home_screen.dart';
import 'pages/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: "/LoginScreen",
      // Set the initial route to your login screen
      routes: {
        "/LoginScreen": (context) => const LoginScreen(),
        "/LoginScreen/HomeScreen": (context) => const HomeScreen(),
        "/HomeScreen/AddStaff": (context) => AddStaffScreen(),
        "/HomeScreen/AddProject": (context) => AddProjectScreen(),
        // Define your login screen route
        // Add other routes for different screens here
      },
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: Pallete.backgroundColor),
      home: //HomeScreen(),
          const LoginScreen(),
      // HomeScreen(),
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => DropdownController());
      }),
      // LoginScreen(),
    );
  }
}
