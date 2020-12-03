import 'package:flutter/material.dart';
import 'package:uas/screens/components/text_field_container.dart';
import 'package:uas/config/pallete.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: Pallete.primaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Pallete.primaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
