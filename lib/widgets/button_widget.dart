import 'package:elector/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';

class WidgetButton extends StatelessWidget {
  String text;
  Color buttonColor;
  Color textColor;

  Function onPress;

  WidgetButton({
    required this.onPress,
    required this.text,
    this.textColor = Colors.white,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
        onPrimary: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        minimumSize: Size(200.w, 40.h),
      ),
      onPressed: () {
        onPress();
      },
      child: LocalizedText(
        text,
        style: GoogleFonts.cairo(
          color: textColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
