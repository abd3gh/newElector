import 'package:elector/api/api_controllers/controllers.dart';
import 'package:elector/constants.dart';
import 'package:elector/screens/manager_group_screens/main_screens/groups/add_support_group.dart';
import 'package:elector/screens/manager_group_screens/main_screens/groups/edit_grop_name.dart';
import 'package:elector/screens/manager_group_screens/main_screens/groups/view_support_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';

class GroupOptionScreen extends StatefulWidget {
  dynamic groupid, userid;
  GroupOptionScreen({Key? key, this.groupid, this.userid}) : super(key: key);

  @override
  State<GroupOptionScreen> createState() => _GroupOptionScreenState();
}

class _GroupOptionScreenState extends State<GroupOptionScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: DraggableScrollableSheet(
        initialChildSize: 0.45,
        maxChildSize: 0.6,
        minChildSize: 0.45,
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
                  vertical: 20.h,
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => AddSupportToGroup(
                                    groupid: widget.groupid))));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LocalizedText(
                            'إضافة تابعين إلى المجموعة',
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
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditGroupName(
                                      groupid: widget.groupid,
                                      userid: widget.userid,
                                    )));
                      },
                      // Navigator.pushNamed(context, '/edit_group_name'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LocalizedText(
                            'تعديل اسم المجموعة',
                            style: GoogleFonts.cairo(
                              color: black,
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(
                            width: 25.w,
                          ),
                          Icon(
                            Icons.edit,
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
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => ViewSupportGroup(
                                      groupid: widget.groupid,
                                    ))));
                        // Navigator.pushNamed(context, '/view_support_group');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LocalizedText(
                            'showfollowerinsidegroup',
                            style: GoogleFonts.cairo(
                              color: black,
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(
                            width: 25.w,
                          ),
                          Icon(
                            Icons.group,
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
                        await ApiControllers()
                            .deletegroup(groupid: widget.groupid);
                        setState(() {
                          showAlertDelete(context);
                        });
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
                      height: 10.h,
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
            "تمت الإضافة إلى التابعين ",
            style: GoogleFonts.cairo(
              color: black,
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
            "تمت الإزالة",
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
