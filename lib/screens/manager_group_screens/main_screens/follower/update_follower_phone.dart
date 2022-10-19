import 'package:elector/api/api_controllers/controllers.dart';
import 'package:elector/constants.dart';
import 'package:elector/widgets/app_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';

class UpdateFollowerPhone extends StatefulWidget {
  const UpdateFollowerPhone({Key? key}) : super(key: key);

  @override
  State<UpdateFollowerPhone> createState() => _UpdateFollowerPhoneState();
}

class _UpdateFollowerPhoneState extends State<UpdateFollowerPhone> {
  TextEditingController phone = TextEditingController();
  bool isloading = false;
  late int id ;

  @override
  Widget build(BuildContext context) {

    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    id = arguments['id'];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: white,
        iconTheme: IconThemeData(
          color: color1,
        ),
        title: LocalizedText(
          'edit',
          style: GoogleFonts.cairo(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: color1,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 100.h,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: LocalizedText(
                'phone',
                style: GoogleFonts.cairo(
                  color: black,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10.h,),
            AppTextField(
              textEditingController: phone,
            ),
            SizedBox(height: 30.h,),
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
                  print(arguments['id']);
                  setState(() {});
                  await ApiControllers().updateFollowerPhone(
                    phone: phone.text.trim(),
                    id:id
                  );
                  phone.clear();
                  Navigator.pushReplacementNamed(context, '/follower_Screen');
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
