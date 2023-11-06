import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:flutter/material.dart';
import 'package:task_management_web_app/pages/add_staff/add_staff_screen.dart';

import '../utils/constants.dart';

class AvatarDropDown extends StatefulWidget {
  final Function(String) onAvatarSelected;

  const AvatarDropDown({
    required this.onAvatarSelected,
    Key? key,
  }) : super(key: key);

  @override
  State<AvatarDropDown> createState() => _AvatarDropDownState();
}

List<String> avatar = [
  'avatar-b-1',
  'avatar-b-2',
  'avatar-b-3',
  'avatar-b-4',
  'avatar-b-5',
  'avatar-b-6',
  'avatar-b-7',
  'avatar-b-8',
  'avatar-b-9',
  'avatar-b-10',
  'avatar-g-1',
  'avatar-g-2',
  'avatar-g-3',
  'avatar-g-4',
  'avatar-g-5',
  'avatar-g-6',
  'avatar-g-7',
  'avatar-g-8',
  'avatar-g-9',
  'avatar-g-10',
];

class _AvatarDropDownState extends State<AvatarDropDown> {
  List<CoolDropdownItem<String>> pokemonDropdownItems = [];
  final pokemonDropdownController = DropdownController();

  @override
  void initState() {
    for (var i = 0; i < avatar.length; i++) {
      pokemonDropdownItems.add(
        CoolDropdownItem<String>(
            label: '${avatar[i]}',
            icon: Container(
              height: 25,
              width: 25,
              child: Image.asset(
                'assets/${avatar[i]}.jpg',
              ),
            ),
            value: '${avatar[i]}'),
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 66,
        maxWidth: screenwidth! * .40,
      ),
      child: Center(
        child: CoolDropdown<String>(
          controller: pokemonDropdownController,
          dropdownList: pokemonDropdownItems,
          defaultItem: pokemonDropdownItems.last,
          onChange: (a) {
            print(a);
            widget.onAvatarSelected(a);

            pokemonDropdownController.close();
          },
          resultOptions: ResultOptions(
            width: screenwidth! * .40,
            render: ResultRender.all,
            icon: const SizedBox(
              width: 10,
              height: 10,
              child: CustomPaint(
                painter: DropdownArrowPainter(color: Colors.green),
              ),
            ),
          ),
          dropdownOptions: const DropdownOptions(
            width: 250,
          ),
          dropdownItemOptions: const DropdownItemOptions(
            isMarquee: true,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            render: DropdownItemRender.all,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            selectedBoxDecoration: BoxDecoration(
              color: Color(0XFFEFFAF0),
            ),
          ),
        ),
      ),
    );
  }
}
