import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:task_management_web_app/utils/pallete.dart';

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return const SpinKitSpinningLines(
      color: Pallete.gradient3,
      size: 50.0,
    );
  }
}
