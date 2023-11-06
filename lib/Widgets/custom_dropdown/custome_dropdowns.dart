// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:task_management_web_app/Widgets/custom_filter_dropdown/custom_filter_dropdown_controller.dart';
// import 'package:task_management_web_app/utils/pallete.dart';
//
// class StylingDropDown extends StatelessWidget {
//   final List<String> listItems;
//   final String iconUrl;
//   final String dropText;
//   final Function(String)?
//       onItemSelected; // Callback function for item selection
//
//   StylingDropDown({
//     required this.dropText,
//     required this.iconUrl,
//     required this.listItems,
//     this.onItemSelected,
//     Key? key,
//   }) : super(key: key);
//
//   final DropdownController controller = Get.put(DropdownController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Obx(
//         () => DropdownButtonHideUnderline(
//           child: DropdownButton2<String>(
//             isExpanded: true,
//             hint: Row(
//               children: [
//                 Image.asset(
//                   iconUrl,
//                   width: 16,
//                   height: 16,
//                   color: Pallete.dateGray,
//                 ),
//                 const SizedBox(
//                   width: 4,
//                 ),
//                 Expanded(
//                   child: Text(
//                     dropText,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                       color: Pallete.dateGray,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),
//             items: listItems
//                 .map((String item) => DropdownMenuItem<String>(
//                       value: item,
//                       child: Text(
//                         item,
//                         style: const TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ))
//                 .toList(),
//             value: controller.selectedValue.value,
//             onChanged: (value) {
//               controller.setSelectedValue(value!);
//             },
//             buttonStyleData: ButtonStyleData(
//               height: 50,
//               width: 160,
//               padding: const EdgeInsets.only(left: 14, right: 14),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(14),
//                 border: Border.all(
//                   color: Colors.black26,
//                 ),
//                 color: Pallete.textFieldBorderColor,
//               ),
//               elevation: 2,
//             ),
//             iconStyleData: const IconStyleData(
//               icon: Icon(
//                 Icons.arrow_forward_ios_outlined,
//               ),
//               iconSize: 14,
//               iconEnabledColor: Pallete.dateGray,
//               iconDisabledColor: Colors.grey,
//             ),
//             dropdownStyleData: DropdownStyleData(
//               maxHeight: 200,
//               width: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(14),
//                 color: Pallete.textFieldBorderColor,
//               ),
//               offset: const Offset(-20, 0),
//               scrollbarTheme: ScrollbarThemeData(
//                 radius: const Radius.circular(40),
//                 thickness: MaterialStateProperty.all(6),
//                 thumbVisibility: MaterialStateProperty.all(true),
//               ),
//             ),
//             menuItemStyleData: const MenuItemStyleData(
//               height: 40,
//               padding: EdgeInsets.only(left: 14, right: 14),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
