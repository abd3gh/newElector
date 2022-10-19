import 'package:elector/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class ActivistOptionScreen extends StatefulWidget {
  dynamic activitistlist;

  ActivistOptionScreen({Key? key, this.activitistlist}) : super(key: key);

  @override
  State<ActivistOptionScreen> createState() => _ActivistOptionScreenState();
}

class _ActivistOptionScreenState extends State<ActivistOptionScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: DraggableScrollableSheet(
        initialChildSize: 0.5,
        maxChildSize: 0.5,
        minChildSize: 0.5,
        builder: (_, controller) => Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 15.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.r),
            ),
            color: white,
          ),
          child: ListView(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.clear,
                    color: black,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 10.h,
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => launchUrl(
                        Uri.parse("sms://${widget.activitistlist['phone']}"),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LocalizedText(
                            'sms',
                            style: GoogleFonts.cairo(
                              color: black,
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(
                            width: 25.w,
                          ),
                          Icon(
                            Icons.sms,
                            color: color1,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Divider(),
                    InkWell(
                      onTap: () async {
                        await launch('${WhatsAppUnilink(
                          phoneNumber: '${widget.activitistlist['phone']}',
                          text: "",
                        )}');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LocalizedText(
                            'whatsapp',
                            style: GoogleFonts.cairo(
                              color: black,
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(
                            width: 25.w,
                          ),
                          Icon(
                            Icons.whatsapp,
                            color: color1,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Divider(),
                    InkWell(
                      onTap: () => launchUrl(
                        Uri.parse("tel://${widget.activitistlist['phone']}"),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LocalizedText(
                            'call',
                            style: GoogleFonts.cairo(
                              color: black,
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(
                            width: 25.w,
                          ),
                          Icon(
                            Icons.phone,
                            color: color1,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Divider(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget continueButton = Center(
      child: TextButton(
          child: LocalizedText(
            "addeddone ",
            style: GoogleFonts.cairo(
              color: color2,
              fontSize: 15.sp,
            ),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          }),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Color(0xffF2F2F2),
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Icon(
          Icons.check_circle,
          size: 35,
          color: color1,
        ),
      ),
      actions: [
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDelete(BuildContext context) {
    Widget continueButton = Center(
      child: TextButton(
          child: LocalizedText(
            "deleteddone",
            style: GoogleFonts.cairo(
              color: color2,
              fontSize: 15.sp,
            ),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          }),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Color(0xffF2F2F2),
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Icon(
          Icons.delete,
          size: 35,
          color: color1,
        ),
      ),
      actions: [
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
