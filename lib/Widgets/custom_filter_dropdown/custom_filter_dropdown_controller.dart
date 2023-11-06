import 'package:get/get.dart';

class FilterDropdownController extends GetxController {
  var selectedValue = ''.obs; // Using an RxString for reactive updates

  void setSelectedValue(String value) {
    selectedValue.value = value;
  }
}
