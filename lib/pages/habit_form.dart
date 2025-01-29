import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker_app/common/themes/app_input_decoration.dart';
import 'package:habit_tracker_app/components/card_form_field.dart';
import 'package:habit_tracker_app/components/date_picker_form_field.dart';
import 'package:habit_tracker_app/cubits/habits_cubit.dart';
import 'package:habit_tracker_app/models/habit.dart';
import 'package:intl/intl.dart';
import '/extensions/habit_extensions.dart';

enum _Repeat { daily, weekly, monthly }

class HabitForm extends StatefulWidget {
  const HabitForm({super.key, this.habit});
  final Habit? habit;

  @override
  State<HabitForm> createState() => _HabitFormState();
}

class _HabitFormState extends State<HabitForm> {
  final _formKey = GlobalKey<FormState>();
  final dateFormater = DateFormat.yMd();
  late final Map<String, dynamic> _formMap;

  @override
  void initState() {
    _formMap = widget.habit?.forForm() ?? {};
    super.initState();
  }

  void _onSaved(String name, dynamic value) {
    _formMap[name] = value;
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_formMap['id'] == null) {
        context
            .read<HabitsCubit>()
            .addHabit(Habit.fromForm(_formMap))
            .then((value) => Navigator.of(context).pop());
      } else {
        context
            .read<HabitsCubit>()
            .updateHabitFromMap(_formMap['id'], _formMap)
            .then((value) => Navigator.of(context).pop());
      }
    }
  }

  void _reset() {
    _formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _formMap['name'],
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                maxLength: 50,
                decoration: const AppInputDecoration(hintText: "Title"),
                validator: (value) {
                  if (value == null || value.isEmpty || value.trim().isEmpty) {
                    return "This field is required and cannot be empty or be only white spaces.";
                  } else if (value.trim().length <= 1) {
                    return "This field must have atleast 2 characters.";
                  }
                  return null;
                },
                onSaved: (newValue) => _onSaved("name", newValue),
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: _formMap['description'],
                minLines: 2,
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                decoration: const AppInputDecoration(hintText: "Description"),
                onSaved: (newValue) => _onSaved("description", newValue),
              ),
              const SizedBox(height: 12),
              CardFormField(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Color",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(14),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              CardFormField(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Repeat",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        CupertinoSwitch(
                          applyTheme: true,
                          value: true,
                          onChanged: (value) {},
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: CupertinoSlidingSegmentedControl(
                        groupValue: _Repeat.daily,
                        children: const {
                          _Repeat.daily: Text("Daily"),
                          _Repeat.weekly: Text("Weekly"),
                          _Repeat.monthly: Text("Monthly"),
                        },
                        onValueChanged: (value) {},
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "On these days",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.filled(
                          7,
                          Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(14),
                            ),
                          )),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              CardFormField(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Start Date",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    DatePickerFormField(
                      initialValue: _formMap['startDate'],
                      onSaved: (newValue) =>
                          _onSaved("startDate", dateFormater.parse(newValue!)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FilledButton.tonal(
                    onPressed: _reset,
                    child: const Text("Reset"),
                  ),
                  const SizedBox(width: 12),
                  FilledButton(
                    onPressed: _submit,
                    child: _formMap["id"] == null
                        ? const Text("Create")
                        : const Text("Save"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
