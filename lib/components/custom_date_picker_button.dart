import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:randevu_al/components/custom_input_area.dart';

class CustomDatePickerButton extends StatefulWidget {
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String placeholder;
  final String formatPattern;
  final void Function(DateTime)? onDateSelected;
  const CustomDatePickerButton(
      {this.initialDate,
      this.firstDate,
      this.lastDate,
      this.placeholder = 'Select Date',
      this.formatPattern = 'dd/MM/yyyy',
      this.onDateSelected,
      super.key});

  @override
  State<CustomDatePickerButton> createState() => _CustomDatePickerButtonState();
}

class _CustomDatePickerButtonState extends State<CustomDatePickerButton> {
  DateTime? selectedDate;
  late final DateFormat formatter = DateFormat(widget.formatPattern);
  late final DateTime now;
  @override
  void initState() {
    now = DateTime.now();
    selectedDate = widget.initialDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomInputArea(
      inputFieldPadding: EdgeInsets.zero,
      textField: TextButton.icon(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        onPressed: () {
          showDatePicker(
            context: context,
            initialDate: widget.initialDate ?? now,
            firstDate:
                widget.firstDate ?? now.subtract(const Duration(days: 5)),
            lastDate: widget.lastDate ?? now.add(const Duration(days: 10)),
          ).then((value) {
            if (value != null) {
              setState(() {
                selectedDate = value;
              });
              widget.onDateSelected?.call(value);
            }
          });
        },
        icon: const Icon(Icons.calendar_month),
        label: Text(selectedDate != null
            ? formatter.format(selectedDate!)
            : widget.placeholder),
      ),
    );
  }
}
