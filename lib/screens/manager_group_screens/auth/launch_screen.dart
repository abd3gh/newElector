import 'dart:convert';

import 'package:elector/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../api/api_controllers/pref_manager.dart';
import '../../box_man_screen/bottom_navigation.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  var userdetails = null;


  // getuserdetails() async {
  //   var data = await PrefManager().get('userdetails', null);
  //   if (kDebugMode) {
  //     print("my data is $data");
  //   }
  //
  //   if (data == null) {
  //     if (kDebugMode) {
  //       print("girai gyi");
  //     }
  //   } else {
  //     userdetails = await json.decode(await PrefManager().get('userdetails', {}));
  //   }
  //
  //   Future.delayed(const Duration(seconds: 4), () {
  //      userdetails['role_id'] == '4'
  //             ? Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => const BottomNavigatorCashier())))
  //             : Navigator.pushReplacementNamed(context, '/bottom_navigator_screen');
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, '/login_screen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            colors: [
              color1,
              color1,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/bg.png',
              color: white,
              height: 220.h,
              width: 220.w,
            ),
          ],
        ),
      ),
    );
  }
}
