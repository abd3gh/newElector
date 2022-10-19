import 'package:elector/constants.dart';
import 'package:elector/screens/manager_group_screens/main_screens/activist/ctivist_option_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';

class ViewMore extends StatefulWidget {
  const ViewMore({Key? key}) : super(key: key);

  @override
  State<ViewMore> createState() => _ViewMoreState();
}

class _ViewMoreState extends State<ViewMore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        margin: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 20.h,
        ),
        padding: EdgeInsets.only(
          top: 5.h,
          bottom: 10.h,
          left: 20.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: color1,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => ActivistOptionScreen(),
                );
                // );
              },
              icon: Icon(
                Icons.more_vert,
                color: color1,
              ),
            ),
            Center(
              child: LocalizedText(
                'Name',
                style: GoogleFonts.cairo(
                  color: color2,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: LocalizedText(
                'Name',
                style: GoogleFonts.cairo(
                  color: color1,
                  fontSize: 14.sp,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: LocalizedText(
                'Name',
                style: GoogleFonts.cairo(
                  color: color1,
                  fontSize: 14.sp,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: LocalizedText(
                'Name',
                style: GoogleFonts.cairo(
                  color: color1,
                  fontSize: 14.sp,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: LocalizedText(
                'Name',
                style: GoogleFonts.cairo(
                  color: color1,
                  fontSize: 14.sp,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: LocalizedText(
                'Name',
                style: GoogleFonts.cairo(
                  color: color1,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
