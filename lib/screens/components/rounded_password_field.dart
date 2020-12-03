import 'package:flutter/material.dart';
import 'package:uas/screens/components/text_field_container.dart';
import 'package:uas/config/pallete.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool secureText = true;

  void showHideText() {
    setState(() {
      secureText = !secureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: secureText,
        onChanged: widget.onChanged,
        cursorColor: Pallete.primaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: Pallete.primaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(secureText ? Icons.visibility_off : Icons.visibility),
            onPressed: showHideText,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
