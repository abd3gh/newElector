import 'package:elector/constants.dart';
import 'package:elector/widgets/app_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';

import '../../api/api_controllers/controllers.dart';

// this for send
class SendNumbers extends StatefulWidget {
  const SendNumbers({Key? key}) : super(key: key);

  @override
  State<SendNumbers> createState() => _SendNumbersState();
}

class _SendNumbersState extends State<SendNumbers> {
  TextEditingController sound1 = TextEditingController();
  TextEditingController sound2 = TextEditingController();
  TextEditingController sound3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: LocalizedText(
                'القائمة العربية الموحدة',
                style: GoogleFonts.cairo(
                  color: black,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            AppTextField(
              textEditingController: sound1,
            ),
            SizedBox(
              height: 15.h,
            ),
            Align(
              alignment: Alignment.topRight,
              child: LocalizedText(
                'الجبهة والتغير',
                style: GoogleFonts.cairo(
                  color: black,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            AppTextField(
              textEditingController: sound2,
            ),
            SizedBox(
              height: 15.h,
            ),
            Align(
              alignment: Alignment.topRight,
              child: LocalizedText(
                'التجمع',
                style: GoogleFonts.cairo(
                  color: black,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            AppTextField(
              textEditingController: sound3,
            ),
            SizedBox(
              height: 15.h,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: color1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  minimumSize: Size(200.w, 50.h),
                ),
                onPressed: () async {
                  setState(() {});
                  await ApiControllers().sendBoxVoteNumber(
                    sounds1: sound1.text.trim(),
                    sounds2: sound2.text.trim(),
                    sounds3: sound3.text.trim(),
                  );

                  setState(() {});
                },
                child: LocalizedText(
                  'send',
                  style: GoogleFonts.cairo(
                    color: white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
