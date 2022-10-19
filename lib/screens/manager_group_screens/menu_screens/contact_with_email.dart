import 'package:elector/api/api_controllers/controllers.dart';
import 'package:elector/constants.dart';
import 'package:elector/widgets/app_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';

class Email_contact extends StatefulWidget {
  const Email_contact({Key? key}) : super(key: key);

  @override
  State<Email_contact> createState() => _Email_contactState();
}

class _Email_contactState extends State<Email_contact> {
  late TextEditingController _phoneController;
  late TextEditingController _messegeController;


  bool isloading = false;

  emailContact() async {
    setState(() {
      isloading = true;
    });
    await ApiControllers().ContactUs(
      email: _phoneController.text.trim(),
      message: _messegeController.text.trim(),
    );

    isloading = false;
    setState(() {});
  }

  @override
  void initState() {
    _phoneController = TextEditingController();
    _messegeController = TextEditingController();
    emailContact();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
    _messegeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: color1,
        ),
        backgroundColor: white,
        title: LocalizedText(
          'تواصل معنا',
          style: GoogleFonts.cairo(
            color: color1,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: white,
      body: Stack(children: [
        Positioned(
          right: MediaQuery.of(context).size.width / 2,
          top: 200.h,
          child: Image.asset('assets/Ellipse 30.png'),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width - 90.w,
          top: -80.h,
          child: Image.asset(
            'assets/Ellipse 30.png',
            height: 147.h,
            width: 147.w,
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 10.h,
          ),
          child: Column(
            children: [
              Image.asset('assets/contact.png', height: 200.h, width: 200.w,),
              LocalizedText(
                'الايميل أو رقم الهاتف',
                style: GoogleFonts.cairo(
                  color: color1,
                  fontSize: 14.sp,
                ),
              ),
              AppTextField(
                textEditingController: _phoneController,

              ),
              SizedBox(height: 10.h),
              LocalizedText(
                'الرسالة',
                style: GoogleFonts.cairo(
                  color: color4,
                  fontSize: 14.sp,
                ),
              ),
              TextField(
                maxLines: 6,
                controller: _messegeController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: color1.withOpacity(0.2),
                      width: 0.3,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: color1.withOpacity(0.2),
                      width: 0.3,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: color3.withOpacity(0.3),
                ),
              ),
              SizedBox(height: 10.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: color1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  minimumSize: Size(200.w, 40.h),
                ),
                onPressed: () {
                  emailContact();
                },
                child: LocalizedText(
                  'إرسال',
                  style: GoogleFonts.cairo(
                    color: white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
