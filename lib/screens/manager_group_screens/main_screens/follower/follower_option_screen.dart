import 'package:elector/api/api_controllers/controllers.dart';
import 'package:elector/constants.dart';
import 'package:elector/screens/manager_group_screens/main_screens/follower/view_voted_follower.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class FollowerOptionScreen extends StatefulWidget {
  dynamic followerlist;

  FollowerOptionScreen({Key? key, this.followerlist}) : super(key: key);

  @override
  State<FollowerOptionScreen> createState() => _FollowerOptionScreenState();
}

class _FollowerOptionScreenState extends State<FollowerOptionScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.followerlist);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: DraggableScrollableSheet(
        initialChildSize: 0.56,
        maxChildSize: 0.56,
        minChildSize: 0.56,
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
                        Uri.parse("sms://${widget.followerlist['phone']}"),
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
                          phoneNumber: '${widget.followerlist['phone']}',
                          text: "",
                        )
                        }');
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
                        Uri.parse("tel://${widget.followerlist['phone']}"),
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
                    const Divider(),
                    InkWell(
                      onTap: () async {
                        await ApiControllers().ddeelleetteeFollower(followerId: widget.followerlist['id']);
                        Navigator.of(context).pop;
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LocalizedText(
                            'delete',
                            style: GoogleFonts.cairo(
                              color: black,
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(
                            width: 25.w,
                          ),
                          Icon(
                            Icons.delete,
                            color: color1,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    const Divider(),
                    InkWell(
                      onTap: () async {
                        print(widget.followerlist['id']);
                        await ApiControllers().addactivitists(context, voters_id: widget.followerlist['id']);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LocalizedText(
                            'addasactivist',
                            style: GoogleFonts.cairo(
                              color: black,
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(
                            width: 25.w,
                          ),
                          Icon(
                            Icons.handshake,
                            color: color1,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const Divider(),
                    InkWell(
                      onTap: () async {
                        // print(widget.followerlist['id']);
                        // await ApiControllers().addactivitists(context, voters_id: widget.followerlist['id']);
                        Navigator.pushNamed(context, '/UpdateFollowerPhone',arguments: {'id': widget.followerlist['id']});
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LocalizedText(
                            'edit',
                            style: GoogleFonts.cairo(
                              color: black,
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(
                            width: 25.w,
                          ),
                          Icon(
                            Icons.handshake,
                            color: color1,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const Divider(),
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
            "addeddone",
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
