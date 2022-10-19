import 'package:elector/constants.dart';
import 'package:elector/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';

class ManualSearch extends StatefulWidget {
  const ManualSearch({Key? key}) : super(key: key);

  @override
  State<ManualSearch> createState() => _ManualSearchState();
}

class _ManualSearchState extends State<ManualSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: color1,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: LocalizedText(
              'البحث عن التابعين',
              style: GoogleFonts.cairo(
                color: color1,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: LocalizedText(
              'اختر الطريقة التي تفضلها',
              style: GoogleFonts.cairo(
                color: color1,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 25.h,
          ),
          Center(
            child: WidgetButton(
              onPress: () {
                Navigator.pushNamed(context, '/search_support_via_name');
              },
              text: 'الاسم',
              buttonColor: color2,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Center(
            child: WidgetButton(
              onPress: () {
                Navigator.pushNamed(context, '/search_support_via_phone');
              },
              text: 'رقم الهاتف',
              buttonColor: color2,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Center(
            child: WidgetButton(
              onPress: () {
                Navigator.pushNamed(context, '/search_support_via_id');
              },
              text: 'رقم الهوية',
              buttonColor: color2,
            ),
          ),
        ],
      ),
    );
  }
}
