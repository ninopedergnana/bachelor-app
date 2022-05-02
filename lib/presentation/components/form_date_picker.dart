import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class FormDatePicker extends StatefulWidget {
  final String title;
  final DateTime date;
  final ValueChanged<DateTime> onChanged;

  const FormDatePicker({
    Key? key,
    required this.title,
    required this.date,
    required this.onChanged,
  }) : super(key: key);

  @override
  FormDatePickerState createState() => FormDatePickerState();
}

class FormDatePickerState extends State<FormDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              widget.title,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              intl.DateFormat.yMMMMd().format(widget.date),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
        TextButton(
          child: const Text('Change'),
          onPressed: () async {
            var newDate = await showDatePicker(
              context: context,
              initialDate: widget.date,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );

            // Don't change the date if the date picker returns null.
            if (newDate == null) {
              return;
            }

            widget.onChanged(newDate);
          },
        )
      ],
    );
  }
}
