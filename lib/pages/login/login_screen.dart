import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_web_app/utils/pallete.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../Widgets/data_table/data_table_controller.dart';
import '../../Widgets/gradient_button.dart';
import '../../Widgets/loading_spinner.dart';
import '../../Widgets/login_field.dart';
import '../../utils/styles.dart';
import 'login_screen_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginScreenController _loginScreenController = LoginScreenController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final dataTableController = Get.put(DataTableController());

  @override
  void initState() {
    dataTableController.getAllStaffNamesList();
    dataTableController.getAllProjectNameList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.titleBlack,
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            child: Column(
              children: [
                Image.asset("assets/images/signin_balls.png"),
                const Text(
                  'Sign in',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                LoginField(
                  hintText: 'Email',
                  isPassword: false,
                  controller: emailController,
                ),
                SizedBox(
                    height: 25,
                    width: 400,
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _loginScreenController.emailValid.isFalse
                              ? Text(
                                  "Email is not valid",
                                  style: logInWaringText,
                                )
                              : const Text(""),
                        ],
                      ),
                    )),
                LoginField(
                  hintText: 'Password',
                  isPassword: true,
                  controller: passwordController,
                ),
                SizedBox(
                  height: 50,
                  width: 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Obx(
                        () => Column(
                          children: [
                            if (_loginScreenController.credentials.isFalse)
                              Text(
                                "Invalid credentials",
                                style: logInWaringText,
                              ),
                            const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.blue,
                                // You can choose the color you prefer
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                GradientButton(
                  buttonFunction: () {
                    _loginScreenController.isEmailValid(emailController.text);
                    _loginScreenController.isCredentialValid(
                        emailController.text, passwordController.text);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => (_loginScreenController.isLoading.value)
                      ? const LoadingSpinner()
                      : const Text(
                          " ",
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is removed from the widget tree
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
