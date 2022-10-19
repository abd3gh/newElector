import 'package:elector/api/api_controllers/controllers.dart';
import 'package:elector/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';

class ViewSupportGroup extends StatefulWidget {
  dynamic groupid;

  ViewSupportGroup({Key? key, this.groupid}) : super(key: key);

  @override
  State<ViewSupportGroup> createState() => _ViewSupportGroupState();
}

class _ViewSupportGroupState extends State<ViewSupportGroup> {
  var supportlist;

  bool isloading = false;

  getsupportinside() async {
    isloading = true;
    setState(() {});
    await ApiControllers().showsupportinsidegroup(widget.groupid).then((value) => {
          supportlist = value['data'],
        });
    isloading = false;
    setState(() {});

    print("my supporters are $supportlist");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getsupportinside();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        centerTitle: true,
        title: LocalizedText(
          'followers',
          style: GoogleFonts.cairo(
            color: color1,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(
          color: color1,
        ),
        backgroundColor: white,
      ),
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: supportlist.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 5.h,
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: 15.w,
                            vertical: 5.h,
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
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      ApiControllers().deletesupportfromgroup(supportid: supportlist[index]['id']).then((value) => {getsupportinside()});
                                    },
                                    icon: Icon(Icons.delete),
                                    color: color2,
                                  ),
                                  Text(
                                    '${supportlist[index]['supporters']['first_name']} ${supportlist[index]['supporters']['second_name']} ${supportlist[index]['supporters']['last_name']}',
                                    style: GoogleFonts.cairo(
                                      color: color1,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  LocalizedText(
                                    'phone',
                                    style: GoogleFonts.cairo(
                                      color: black,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  Text(
                                    ' :  ${supportlist[index]['phone'] == null ? "غير مسجل" : supportlist[index]['phone']}',
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
                                    'ID',
                                    style: GoogleFonts.cairo(
                                      color: black,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  Text(
                                    ' :  ${supportlist[index]['supporters']['idc']}',
                                    style: GoogleFonts.cairo(
                                      color: color1,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
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
}
