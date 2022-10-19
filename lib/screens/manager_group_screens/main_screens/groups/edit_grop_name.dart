import 'package:elector/api/api_controllers/controllers.dart';
import 'package:elector/constants.dart';
import 'package:elector/widgets/app_text_feild.dart';
import 'package:elector/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EditGroupName extends StatefulWidget {
  dynamic groupid, userid;
  EditGroupName({Key? key, this.groupid, this.userid}) : super(key: key);

  @override
  State<EditGroupName> createState() => _EditGroupNameState();
}

class _EditGroupNameState extends State<EditGroupName> {
  late TextEditingController _groupNameController;

  @override
  void initState() {
    _groupNameController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _groupNameController.dispose();
  }

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    // isloading = false;
    //             setState(() {});
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: color1,
        ),
        backgroundColor: white,
        elevation: 0,
      ),
      body: ModalProgressHUD(
        inAsyncCall: isloading,
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 25.w,
            vertical: 50.h,
          ),
          child: Column(
            children: [
              LocalizedText(
                'groupname',
                style: GoogleFonts.cairo(
                  color: color4,
                  fontSize: 14.sp,
                ),
              ),
              AppTextField(
                textEditingController: _groupNameController,
              ),
              SizedBox(
                height: 25.h,
              ),
              WidgetButton(
                onPress: () async {
                  isloading = true;
                  setState(() {});
                  await ApiControllers().updategroupname(
                      groupid: widget.groupid,
                      groupname: _groupNameController.text.trim());

                  isloading = false;
                  setState(() {});
                  // ignore: use_build_context_synchronously
                  showAlertDialog(context);

                  _groupNameController.clear();
                },
                text: 'edit',
                buttonColor: color2,
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
            "groupedirsucess",
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
}
