import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerTextField extends StatefulWidget {
  final TextEditingController dateinput;
  final Function(String)
      onChanged; // Callback function to return the selected date
  final TextStyle fieldText;

  DatePickerTextField({
    required this.onChanged,
    required this.dateinput,
    required this.fieldText,
    Key? key, // Fix the super.key parameter
  }) : super(key: key);

  @override
  State<DatePickerTextField> createState() => _DatePickerTextFieldState();
}

class _DatePickerTextFieldState extends State<DatePickerTextField> {
  @override
  void initState() {
    DateTime currentDate = DateTime.now();

    widget.dateinput.text = _formatDate(currentDate);
    // widget.onChanged(_formatDate(currentDate));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextField(
        style: widget.fieldText,
        controller: widget.dateinput,
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );

          if (pickedDate != null) {
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            setState(() {
              widget.dateinput.text = formattedDate;
              widget.onChanged(
                  formattedDate); // Call the callback function with formattedDate
            });
          }
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
}

class DatePickerTextFieldNew extends StatefulWidget {
  final TextEditingController dateinput;
  Function(DateTime) onChanged; // Change the parameter type to DateTime
  final TextStyle fieldText;

  DatePickerTextFieldNew({
    required this.onChanged,
    required this.dateinput,
    required this.fieldText,
    super.key,
  });

  @override
  State<DatePickerTextFieldNew> createState() => _DatePickerTextFieldNewState();
}

class _DatePickerTextFieldNewState extends State<DatePickerTextFieldNew> {
  @override
  void initState() {
    DateTime currentDate = DateTime.now();

    widget.dateinput.text =
        _formatDate(currentDate); // set the initial value of the text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = _formatDate(DateTime.now());
    return Center(
      child: TextField(
        style: widget.fieldText,
        controller: widget.dateinput,
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );

          if (pickedDate != null) {
            widget.dateinput.text = _formatDate(pickedDate);
            widget.onChanged(pickedDate); // Pass the DateTime value
          } else {
            print("Date is not selected");
          }
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
