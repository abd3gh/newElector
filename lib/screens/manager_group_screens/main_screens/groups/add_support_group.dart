import 'package:elector/constants.dart';
import 'package:elector/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';

import '../../../../api/api_controllers/controllers.dart';

class AddSupportToGroup extends StatefulWidget {
  dynamic groupid;

  AddSupportToGroup({Key? key, this.groupid}) : super(key: key);

  @override
  State<AddSupportToGroup> createState() => _AddSupportToGroupState();
}

class _AddSupportToGroupState extends State<AddSupportToGroup> {
  var followerslist;

  bool isloading = false;

  List<bool> ischecked = [];

  getelectors() async {
    isloading = true;
    setState(() {});
    await ApiControllers().getfollowers().then((value) => {
          followerslist = value['data'],
          for (int i = 0; i < followerslist.length; i++) {ischecked.add(false)}
        });
    isloading = false;
    setState(() {});

    print("my followers are $followerslist");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getelectors();
  }

  List<dynamic> selectedfollowers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        iconTheme: IconThemeData(
          color: color1,
        ),
      ),
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 25.w,
                    vertical: 10.h,
                  ),
                  child: WidgetButton(
                    onPress: () async {
                      var datas = {};
                      for (int i = 0; i < selectedfollowers.length; i++) {
                        await ApiControllers().addsupporttogroup(group_id: widget.groupid, supporters_id: selectedfollowers[i]);

                        Fluttertoast.showToast(msg: 'supporter added successfully');
                        // datas = {
                        //   "group_id": widget.groupid,
                        //   "supporters_id": selectedfollowers[i]
                        // };
                      }

                      //print("my datas is $datas");
                      showAlertDialog(context);
                    },
                    text: 'add',
                    buttonColor: color1,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: followerslist.length,
                      itemBuilder: (context, i) {
                        // bool _isChecked = false;
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: 15.w,
                            vertical: 5.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10.r,
                            ),
                            border: Border.all(
                              color: color1,
                              width: 1.w,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${followerslist[i]['first_name']} ${followerslist[i]['second_name']} ${followerslist[i]['last_name']}',
                                style: GoogleFonts.cairo(
                                  color: color1,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Checkbox(
                                checkColor: white,
                                activeColor: color1,
                                value: ischecked[i],
                                onChanged: (value) {
                                  setState(() {
                                    ischecked[i] = value!;

                                    var datas = {"group_id": widget.groupid, "supporters_id": followerslist[i]['id']};
                                    if (ischecked[i] == false) {
                                      selectedfollowers.remove(datas['supporters_id']);
                                    } else {
                                      selectedfollowers.add(datas['supporters_id']);
                                    }
                                  });

                                  print("followerslist is $selectedfollowers");
                                },
                              ),

                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
    );
  }



  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: LocalizedText(
        "إنهاء",
        style: GoogleFonts.cairo(
          color: color1,
          fontSize: 15.sp,
        ),
      ),
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/group_screen');
      },
    );
    Widget continueButton = TextButton(
      child: LocalizedText(
        "متابعة الإضافة",
        style: GoogleFonts.cairo(
          color: color1,
          fontSize: 15.sp,
        ),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: LocalizedText(
        "تمت الإضافة إلى المجموعة ",
        style: GoogleFonts.cairo(
          color: color1,
          fontSize: 15.sp,
        ),
      ),
      actions: [
        cancelButton,
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
