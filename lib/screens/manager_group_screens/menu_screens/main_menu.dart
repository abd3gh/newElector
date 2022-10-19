import 'dart:convert';
import 'dart:io';

import 'package:elector/api/api_controllers/controllers.dart';
import 'package:elector/api/api_controllers/pref_manager.dart';
import 'package:elector/constants.dart';
import 'package:elector/screens/manager_group_screens/auth/login_screen.dart';
import 'package:elector/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:slidable_button/slidable_button.dart';
import 'package:url_launcher/url_launcher.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  bool isloading = false;
  String result = "Let's slide!";
  String s = 'غير معرف';
  bool _isVisible = true;
  List listofcontacts = [];

  sendcontacts() async {
    isloading = true;
    setState(() {});
    // Request contact permission
    if (await FlutterContacts.requestPermission()) {
      // Get all contacts (lightly fetched)
      List<Contact> contacts;
      var details =
          await json.decode(await PrefManager().get('userdetails', {}));
      print("im followers ${details['id']}");

      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
      List listofcontacts = [];
      for (int i = 0; i < contacts.length; i++) {
        try {
          listofcontacts.add(
            {
              "user_id": details['id'],
              "name": contacts[i].displayName,
              "phone": contacts[i].phones[0].number
            },
          );
          print(listofcontacts);

          Fluttertoast.showToast(
            msg: "Contact has been send",
          );
        } catch (e) {}
      }
      ApiControllers().storecontacts(name: listofcontacts);
    }

    isloading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getName();
  }

  getName() async {
    s = await PrefManager().getName();
    print('my name $s');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final klocalizations = KLocalizations.of(context);
    return Scaffold(
      backgroundColor: white,
      body: ModalProgressHUD(
        inAsyncCall: isloading,
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.only(
              right: 20.w,
              left: 20.w,
              top: 20.h,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      'assets/bg.png',
                      color: color1,
                      height: 90.h,
                      width: 150.w,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      '$s',
                      style: GoogleFonts.cairo(
                        color: color1,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(
                    color: color1.withOpacity(0.3),
                    thickness: 0.4,
                  ),
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, '/group_screen'),
                    child: const MenuRow(
                      icon: Icons.groups,
                      title: 'group',
                    ),
                  ),

                  // InkWell(
                  //   onTap: () => Navigator.pushNamed(context, '/add_voter_manually'),
                  //   child: const MenuRow(
                  //     icon: Icons.front_hand_rounded,
                  //     title: 'addmanualvoter',
                  //   ),
                  // ),
                  Divider(
                    color: color1.withOpacity(0.3),
                    thickness: 0.4,
                  ),
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, '/follower_Screen'),
                    child: const MenuRow(
                      icon: Icons.group,
                      title: 'followers',
                    ),
                  ),
                  Divider(
                    color: color1.withOpacity(0.3),
                    thickness: 0.4,
                  ),
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, '/activist_screen'),
                    child: const MenuRow(
                      icon: Icons.handshake,
                      title: 'activist',
                    ),
                  ),
                  Divider(
                    color: color1.withOpacity(0.3),
                    thickness: 0.4,
                  ),
                  InkWell(
                    onTap: () async {
                      sendcontacts();
                    },
                    child: const MenuRow(
                      icon: Icons.wifi_calling_3_rounded,
                      title: 'sendcontact',
                    ),
                  ),
                  Divider(
                    color: color1.withOpacity(0.3),
                    thickness: 0.4,
                  ),
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, 'manual_search'),
                    child: const MenuRow(
                      icon: Icons.search,
                      title: 'search',
                    ),
                  ),
                  Divider(
                    color: color1.withOpacity(0.3),
                    thickness: 0.4,
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pushNamed('/calender'),
                    child: const MenuRow(
                      icon: Icons.calendar_month_outlined,
                      title: 'calender',
                    ),
                  ),
                  Divider(
                    color: color1.withOpacity(0.3),
                    thickness: 0.4,
                  ),
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, '/demo_video'),
                    child: const MenuRow(
                      icon: Icons.video_collection_rounded,
                      title: 'video',
                    ),
                  ),
                  Divider(
                    color: color1.withOpacity(0.3),
                    thickness: 0.4,
                  ),
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, '/email_contact'),
                    child: const MenuRow(
                      icon: Icons.contacts_sharp,
                      title: 'contactus',
                    ),
                  ),
                  Divider(
                    color: color1.withOpacity(0.3),
                    thickness: 0.4,
                  ),
                  InkWell(
                    onTap: () => launchUrl(
                      Uri.parse("https://mw7de.co.il/privacy/"),
                    ),
                    child: const MenuRow(
                      icon: Icons.privacy_tip_outlined,
                      title: 'privacy',
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  HorizontalSlidableButton(
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
                  SizedBox(
                    height: 25.h,
                  ),
                  Center(
                    child: WidgetButton(
                      onPress: () async {
                        await PrefManager().remove('userdetails');
                        Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()))
                            .then((value) => {exit(0)});
                      },
                      //  await Navigator.pushNamed(context, 'routeName'),
                      text: 'تسجيل الخروج ',
                      buttonColor: color1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MenuRow extends StatelessWidget {
  const MenuRow({Key? key, required this.title, required this.icon})
      : super(key: key);
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color1,
          size: 20,
        ),
        SizedBox(
          width: 20.w,
        ),
        LocalizedText(
          title,
          style: GoogleFonts.cairo(
            color: black,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
