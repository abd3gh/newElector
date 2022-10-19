import 'package:elector/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.textEditingController,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.hint = '',
  }) : super(key: key);

  final String hint;
  final TextInputType textInputType;
  final TextEditingController textEditingController;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      obscureText: obscureText,
      keyboardType: textInputType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 0),
        filled: true,
        fillColor: color3.withOpacity(0.3),
        enabledBorder: border(),
        focusedBorder: border(
          borderColor: color1,
        ),
      ),
    );
  }

  OutlineInputBorder border({Color borderColor = Colors.grey}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color1.withOpacity(0.2),
        width: 0.3,
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
