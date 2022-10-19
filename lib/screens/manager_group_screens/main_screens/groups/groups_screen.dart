import 'package:elector/constants.dart';
import 'package:elector/screens/manager_group_screens/main_screens/groups/group_option_screen.dart';
import 'package:elector/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';

import '../../../../api/api_controllers/controllers.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({Key? key}) : super(key: key);

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  var grouplist;
  bool isloading = false;
  getgroups() async {
    isloading = true;
    setState(() {});
    await ApiControllers()
        .getagroups()
        .then((value) => {grouplist = value['data']});
    isloading = false;
    setState(() {});

    print("my grouplist are $grouplist");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getgroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: LocalizedText(
          'group',
          style: GoogleFonts.cairo(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: color1,
          ),

        ),
        centerTitle: true,

        backgroundColor: white,
      ),
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(height: 12.h,),
                  WidgetButton(
                    onPress: () {
                      Navigator.pushNamed(context, '/create_group')
                          .then((value) => {getgroups()});
                    },
                    text: 'creatgroup',
                    buttonColor: color1,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: grouplist.length,
                        itemBuilder: (context, index) {
                          var value = grouplist[index];
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                            ),
                            margin: EdgeInsets.symmetric(
                              horizontal: 15.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                15.r,
                              ),
                              border: Border.all(
                                color: color1,
                                width: 1.w,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                LocalizedText(
                                  '${value['name']}',
                                  style: GoogleFonts.cairo(
                                    color: color1,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) => GroupOptionScreen(
                                        groupid: value['id'],
                                        userid: value['userid'],
                                      ),
                                    ).then((value) => {getgroups()});
                                  },
                                  icon: Icon(
                                    Icons.more_vert,
                                    color: color1,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
    );
  }
}
