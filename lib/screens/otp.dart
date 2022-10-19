import 'package:elector/constants.dart';
import 'package:elector/widgets/app_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';

import '../api/api_controllers/controllers.dart';
import '../widgets/button_widget.dart';

class OTPScreen extends StatefulWidget {
  dynamic phone;

  OTPScreen({Key? key, this.phone}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late TextEditingController _OTPController;


  @override
  void initState() {
    _OTPController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _OTPController.dispose();
  }

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
 //   sendcontacts();
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 30.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LocalizedText(
              'enterotp',
              style: GoogleFonts.cairo(
                fontSize: 20.sp,
                color: color1,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            AppTextField(
              textEditingController: _OTPController,
            ),
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: WidgetButton(
                onPress: () async {
                  setState(() {});
                  await ApiControllers().verifyOTP(
                    context,
                    phone: widget.phone,
                    otp: _OTPController.text.trim(),
                  );

                },
                text: 'تأكيد',
                buttonColor: color1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
