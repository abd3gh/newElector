import 'package:elector/api/api_controllers/controllers.dart';
import 'package:elector/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';

class Nakhibeen extends StatefulWidget {
  const Nakhibeen({Key? key}) : super(key: key);

  @override
  State<Nakhibeen> createState() => _NakhibeenState();
}

class _NakhibeenState extends State<Nakhibeen> {
  bool isloading = false;
  int days = 0;
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  int fllowNum = 0;
  int unfllowNum = 0;

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  getSettings() async {
    isloading = true;
    setState(() {});
    await ApiControllers().getSetting().then((value) {
      DateTime dt1 = DateTime.parse(DateTime.now().toString());
      DateTime dt2 = DateTime.parse(value['data']['time']);
      print("dfe ${value['data']['time']}");
      Duration diff = dt1.difference(dt2);
      List<String> s1 = value['data']['time'].split(' ');
      List<String> s2 = s1[1].split(':');
      if (!(daysBetween(dt1, dt2) < 0)) {
        days = daysBetween(dt1, dt2);
        hours = (dt1.hour - int.parse(s2[0])).abs();
        // minutes = diff.inMinutes.abs();
        minutes = (dt1.minute - int.parse(s2[1])).abs();
        seconds = (dt1.second - int.parse(s2[2])).abs();
        // seconds = diff.inSeconds.abs();
      }
      isloading = false;
      setState(() {});
    });
  }

  bool appear = true;

  @override
  void initState() {
    super.initState();
    getSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LocalizedText(
            ' الوقت المتبقي للانتخابات',
            style: GoogleFonts.cairo(
              color: color1,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    '$days',
                    style: GoogleFonts.cairo(
                      color: color1,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  LocalizedText(
                    'day',
                    style: GoogleFonts.cairo(
                      color: color1,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    '$hours',
                    style: GoogleFonts.cairo(
                      color: color1,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  LocalizedText(
                    'hr',
                    style: GoogleFonts.cairo(
                      color: color1,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    '$minutes',
                    style: GoogleFonts.cairo(
                      color: color1,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  LocalizedText(
                    'min',
                    style: GoogleFonts.cairo(
                      color: color1,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    '$seconds',
                    style: GoogleFonts.cairo(
                      color: color1,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  LocalizedText(
                    'sec',
                    style: GoogleFonts.cairo(
                      color: color1,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: color1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                minimumSize: Size(200.w, 40.h),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/voter_without_num_screen');
              },
              child: LocalizedText(
                'nakhebwithoutnum',
                style: GoogleFonts.cairo(
                  color: white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: color1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              minimumSize: Size(200.w, 40.h),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/voter_from_contact');
            },
            child: LocalizedText(
              'nakhenwithnum',
              style: GoogleFonts.cairo(
                color: white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
