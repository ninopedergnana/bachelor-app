import 'package:flutter/material.dart';
import 'package:flutter_app/domain/model/template.dart';

class DropDownButtonWidget extends StatefulWidget {
  // used to pass the right template to the create vaccine widget
  final ValueChanged<Template> onValueChanged;

  const DropDownButtonWidget({Key? key, required this.onValueChanged}) : super(key: key);

  @override
  State<DropDownButtonWidget> createState() => DropDownButtonWidgetState();
}

class DropDownButtonWidgetState extends State<DropDownButtonWidget> {
  Template? chosenTemplate; // will be filled with one from the list
  List<Template> templates = Template.getDefaultTemplates();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: DropdownButtonFormField<Template>(
        decoration: const InputDecoration(
          labelText: "Choose a Template"
        ),
        value: chosenTemplate == null ? null : templates[0],
        icon: const Icon(Icons.arrow_downward),
        isExpanded: true,
        elevation: 16,
        style: const TextStyle(color: Colors.blueGrey),
        onChanged: (Template? newTemplate) {
          setState(() {
            chosenTemplate = newTemplate!;
          });
          // passes chosen template to create widget. same style as datepicker
          widget.onValueChanged(chosenTemplate!);
        },
        items: templates.map((Template template) {
          return DropdownMenuItem<Template>(
            value: template,
            child: Text(template.templateName!),
          );
        }).toList(),
      ),
    );
  }
}
