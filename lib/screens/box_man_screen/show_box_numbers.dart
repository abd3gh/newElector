import 'package:elector/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';

import '../../api/api_controllers/controllers.dart';

class ShowNumbers extends StatefulWidget {
  const ShowNumbers({Key? key}) : super(key: key);

  @override
  State<ShowNumbers> createState() => _ShowNumbersState();
}

class _ShowNumbersState extends State<ShowNumbers> {
  bool isloading = false;
  var numberlist = {};



  getnumberlist() async {
    isloading = true;
    setState(() {});
    await ApiControllers().getBoxVoteNumber().then((value) => {
      if(value['data'] != null)
       numberlist = value['data'],

    });
    isloading = false;
    setState(() {});

    print("my numberlist are $numberlist");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getnumberlist();
  }
  @override
  Widget build(BuildContext context) {
    //getnumberlist();
    return Scaffold(
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: AppBar(
                backgroundColor: white,
                centerTitle: true,
                title: LocalizedText(
                  'vvoott',
                  style: GoogleFonts.cairo(
                    color: color1,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                  horizontal: 25.w,
                  vertical: 15.h,
                ),
                child: Column(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        margin: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 20.h,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 15.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 3,
                              offset: const Offset(0, 3),
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Row(
                              children: [
                                LocalizedText(
                                  'القائمة العربية الموحدة',
                                  style: GoogleFonts.cairo(
                                    color: black,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                Text(
                                  ' : ${numberlist['sounds1']}',
                                  style: GoogleFonts.cairo(
                                    color: black,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                LocalizedText(
                                  'القائمة المشتركة',
                                  style: GoogleFonts.cairo(
                                    color: black,
                                    fontSize: 14.sp,

                                  ),
                                ),
                                Text(
                                  ' : ${numberlist['sounds2']}',
                                  style: GoogleFonts.cairo(
                                    color: black,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                LocalizedText(
                                  'أخرى',
                                  style: GoogleFonts.cairo(
                                    color: black,
                                    fontSize: 14.sp,

                                  ),
                                ),
                                Text(
                                  ' : ${numberlist['sounds3']}',
                                  style: GoogleFonts.cairo(
                                    color: black,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                     ),
                  ],
                ),
              ),
            ),
    );
  }
}
