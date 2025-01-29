import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker_app/common/themes/app_input_decoration.dart';
import 'package:intl/intl.dart';

class DatePickerFormField extends StatefulWidget {
  const DatePickerFormField({super.key, this.onSaved, this.initialValue});

  final String? initialValue;
  final void Function(String? newValue)? onSaved;

  @override
  State<DatePickerFormField> createState() => _DatePickerFormFieldState();
}

class _DatePickerFormFieldState extends State<DatePickerFormField> {
  final dateFormater = DateFormat.yMd();
  late final TextEditingController _dateController;

  @override
  void initState() {
    final initialDate = DateTime.tryParse(widget.initialValue ?? "");
    _dateController = TextEditingController(
        text: dateFormater.format(initialDate ?? DateTime.now()));

    super.initState();
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  _showDatePicker() async {
    // context: context,
    //     initialDate: dateFormater.parse(_dateController.text),
    //     firstDate: DateTime(now.year - 1, now.month, now.day),
    //     lastDate: now
    final now = DateTime.now();
    // final newDate =
    _showDialog(CupertinoDatePicker(
      initialDateTime: dateFormater.parse(_dateController.text),
      maximumDate: now,
      minimumDate: DateTime(now.year - 1, now.month, now.day),
      onDateTimeChanged: (newDate) =>
          {_dateController.text = dateFormater.format(newDate)},
    ));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.datetime,
      textInputAction: TextInputAction.next,
      readOnly: true,
      controller: _dateController,
      onTap: _showDatePicker,
      decoration: const AppInputDecoration(
        hintText: "Start Date",
        prefixIcon: Icon(Icons.date_range_outlined),
      ),
      validator: (value) {
        if (value == null || value.isEmpty || value.trim().isEmpty) {
          return "This field is required and cannot be empty or be only white spaces.";
        }
        return null;
      },
      onSaved: widget.onSaved,
    );
  }
}
