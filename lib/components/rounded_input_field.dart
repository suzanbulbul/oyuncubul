import 'package:flutter/material.dart';
import 'package:oyuncubul/components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String text;
  final Icon icon;
  final ValueChanged<String> onChanged;

  const RoundedInputField({
    Key key,
    this.text,
    this.icon,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: icon,
          hintText: text,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
