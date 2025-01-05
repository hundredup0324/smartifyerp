import 'package:attendance/core/model/leave_types_response.dart';
import 'package:flutter/material.dart';

class CustomDropDown<T extends LeaveType> extends StatelessWidget {
  const CustomDropDown({
    Key? key,
    required this.items,
    required this.onChanged,
    this.value,
  }) : super(key: key);

  final List<T> items;

  final Function(T?) onChanged;
  final T? value;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(

      hint: const Text('Post'),
      value: value,
      underline: SizedBox(),

      items: items.map((model) {
        return DropdownMenuItem<T>(
          value: model,
          child: Text(model.title!),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}