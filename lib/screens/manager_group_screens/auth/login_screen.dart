import 'package:elector/constants.dart';
import 'package:elector/widgets/app_text_feild.dart';
import 'package:elector/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slidable_button/slidable_button.dart';

import '../../../api/api_controllers/controllers.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isloading = false;

  // List listofcontacts = [];

  // sendcontacts() async {
  //   isloading = true;
  //   setState(() {});
  //   // Request contact permission
  //   if (await FlutterContacts.requestPermission()) {
  //     // Get all contacts (lightly fetched)
  //     List<Contact> contacts;
  //     contacts = await FlutterContacts.getContacts(withProperties: true, withPhoto: true);
  //
  //     for (int i = 0; i < contacts.length; i++) {
  //       try {
  //         listofcontacts.add(
  //           {"user_id": 2, "name": contacts[i].displayName, "phone": contacts[i].phones[0].number},
  //         );
  //         Fluttertoast.showToast(
  //           msg: "Contact has been send",
  //         );
  //       } catch (e) {}
  //     }
  //     print(listofcontacts);
  //     var con = await FlutterContacts.openExternalView(contacts[0].id);
  //     ApiControllers().storecontacts(name: contacts);
  //     // print("my contacts are $con");
  //   }
  //
  //   isloading = false;
  //   setState(() {});
  // }

  String result = "Let's slide!";
  late TextEditingController _phoneTextEditingController;
  late TextEditingController _passwordTextEditingController;
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    showDialogIfFirstLoaded(context);
    // sendcontacts();
    _phoneTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();

    //getcontacts();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneTextEditingController.dispose();
    _passwordTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyIsFirstLoaded = true;

    final klocalizations = KLocalizations.of(context);

    setState(() {
      isloading = false;
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: white,
      body: ModalProgressHUD(
        inAsyncCall: isloading,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.8,
              decoration: BoxDecoration(
                color: color1,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(60.r),
                  bottomLeft: Radius.circular(60.r),
                ),
              ),
            ),
            SafeArea(
              child: Container(
                alignment: Alignment.topCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.asset(
                    'assets/bg.png',
                    color: white,
                    height: 100.h,
                    width: 100.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              height: 350.h,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(30.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              margin: EdgeInsets.symmetric(
                horizontal: 40.w,
                vertical: 160.h,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 30.w,
                vertical: 10.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: HorizontalSlidableButton(
                      width: MediaQuery.of(context).size.width / 3,
                      buttonWidth: 62.w,
                      color: color1,
                      buttonColor: white,
                      dismissible: false,
                      label: Center(
                        child: Image.asset(
                          'assets/scroll.png',
                          height: 20,
                          color: color1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          LocalizedText(
                            'العربية',
                            style: GoogleFonts.cairo(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                          ),
                          LocalizedText(
                            'עִברִית',
                            style: GoogleFonts.cairo(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      onChanged: (position) {
                        setState(() {
                          if (position == SlidableButtonPosition.end) {
                            result = 'العربية';
                            klocalizations.setLocale(const Locale('ar', 'AR'));
                          } else {
                            result = 'עִברִית';
                            klocalizations.setLocale(const Locale('he', 'HE'));
                          }
                        });
                        //  Phoenix.rebirth(context);
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 10.h, bottom: 5.h),
                    child: LocalizedText(
                      'login',
                      style: GoogleFonts.cairo(
                        color: color1,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  LocalizedText(
                    'phone',
                    style: GoogleFonts.cairo(
                      color: black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextField(
                    controller: _phoneTextEditingController,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone_android,
                        color: color1,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  LocalizedText(
                    'password',
                    style: GoogleFonts.cairo(
                      color: black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextField(
                    controller: _passwordTextEditingController,
                    obscureText: !_passwordVisible,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: color1,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible ? Icons.visibility : Icons.visibility_off,
                          color: color1,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Center(
                    child: WidgetButton(
                      onPress: () async {
                        isloading = true;
                        setState(() {});
                        await ApiControllers().Login(
                          context,
                          phone: _phoneTextEditingController.text.trim(),
                          password: _passwordTextEditingController.text.trim(),
                        );

                        isloading = false;
                        setState(() {});
                      },
                      text: 'login',
                      buttonColor: color1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  showDialogIfFirstLoaded(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstLoaded = prefs.getBool('isfirstload');
    if (isFirstLoaded == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Text(
              "הגנת פרטיות",
              style: GoogleFonts.cairo(
                color: black,
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              "בהסכמתי שלהלן לתנאי השימוש במערכת ובאפלקציה , אני מתחייב בזאת כי המידע שאליו איחשף ישמש אך ורק למטרת הבחירות.כמו כן, אני מתחייב שלא להעתיק את המידע, או כל חלק ממנו. כמו כן - טיוב מידע על מצביע דורש הסכמתו המפורשת להיכלל במאגר. בנוסף אין להעביר את המידע - כולו, חלקו ואו כל תוצר שהופק ממנו. כמו כן האפלקציה תדרש  אישור לספר טלפונים למטרת בדיקת זכות חברי בחירה מספר טלפונים.",
              style: GoogleFonts.cairo(
                color: black,
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: color1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  minimumSize: Size(150.w, 40.h),
                ),
                child: LocalizedText(
                  "אישור",
                  style: GoogleFonts.cairo(
                    color: white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  prefs.setBool('isfirstload', false);
                },
              ),
            ],
          );
        },
      );
    }
  }
}
