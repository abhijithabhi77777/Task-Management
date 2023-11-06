import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_management_web_app/utils/pallete.dart';

class StylingDatePicker extends StatefulWidget {

  final Function(String) onDateSelected;

  const StylingDatePicker({
   
    required this.onDateSelected,
    Key? key,
  }) : super(key: key);

  @override
  State<StylingDatePicker> createState() => _StylingDatePickerState();
}

class _StylingDatePickerState extends State<StylingDatePicker> {
  late TextEditingController dateController;

  @override
  void initState() {
    super.initState();
    DateTime currentDate = DateTime.now();
    dateController = TextEditingController(text: _formatDate(currentDate));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.black26,
          ),
          color: Pallete.textFieldBorderColor,
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.calendar_today,
                color: Pallete.dateGray,
                size: 24,
              ),
            ),
            Expanded(
              child: TextFormField(
                onTap: () {
                  _selectDate(context);
                },
                controller: dateController,
                readOnly: true,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Pallete.dateGray,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.parse(dateController.text)) {
      setState(() {
        dateController.text = "${picked.year}-${picked.month}-${picked.day}";
        widget.onDateSelected(dateController.text);
      });
    }
  }
}
