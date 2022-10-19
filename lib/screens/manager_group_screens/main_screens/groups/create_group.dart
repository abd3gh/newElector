import 'package:elector/api/api_controllers/controllers.dart';
import 'package:elector/constants.dart';
import 'package:elector/widgets/app_text_feild.dart';
import 'package:elector/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
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

  addgroup() async {
    setState(() {
      isloading = true;
    });
    await ApiControllers()
        .creategroup(groupname: _groupNameController.text.trim());

    isloading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
      body: Container(
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
              onPress: () {
                addgroup();
                showAlertDialog(context);
                _groupNameController.clear();
              },
              text: 'creatgroup',
              buttonColor: color2,
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget continueButton = Center(
      child: TextButton(
          child: LocalizedText(
            "groupcreatedsucess",
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
