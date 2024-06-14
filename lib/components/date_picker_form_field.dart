import 'package:flutter/material.dart';
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

  _showDatePicker() async {
    final now = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: dateFormater.parse(_dateController.text),
        firstDate: DateTime(now.year - 1, now.month, now.day),
        lastDate: now);
    if (newDate != null) {
      _dateController.text = dateFormater.format(newDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.datetime,
      textInputAction: TextInputAction.next,
      readOnly: true,
      controller: _dateController,
      onTap: _showDatePicker,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.date_range_outlined),
        label: Text("Start Date"),
        errorMaxLines: 3,
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
