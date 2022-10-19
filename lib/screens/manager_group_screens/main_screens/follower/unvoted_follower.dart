import 'package:elector/api/api_controllers/controllers.dart';
import 'package:elector/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';

import '../../../../widgets/button_widget.dart';

class UnVotedFollower extends StatefulWidget {
  const UnVotedFollower({Key? key}) : super(key: key);

  @override
  State<UnVotedFollower> createState() => _UnVotedFollowerState();
}

class _UnVotedFollowerState extends State<UnVotedFollower> {
  var followerslist;
  String message = "hi";
  List<String> recipents = [];

  var voted;
  bool isloading = false;
  List<dynamic> unVotedFoll = [];

  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print("fdd ${_result}");
  }

  getUnvotedFollower() async {
    isloading = true;
    setState(() {});
    await ApiControllers().getfollowers().then((value){
          followerslist = value['data'];
          for (int i = 0; i < followerslist.length; i++)
            {
              if (followerslist[i]['voted'] == null)
                {}
              else
                {
                  if (followerslist[i]['voted'] == 1)
                    {}
                  else
                    {
                      unVotedFoll.add(followerslist[i],);
                    }
                }
            }

          unVotedFoll.forEach((element) {
            if(element['phone'] != null)
              recipents.add(element['phone']);
            // print("my followers are dfes $recipents");
          });
        });
    isloading = false;
    setState(() {});

    // print("my followers are $followerslist");
  }

  @override
  void initState() {
    super.initState();
    getUnvotedFollower();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LocalizedText(
          'unvotedfollowers',
          style: GoogleFonts.cairo(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: color1,
          ),
        ),
        centerTitle: true,
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
              SizedBox(
                height: 15.h,
              ),
              WidgetButton(
                onPress: () async {
                  // print("gggg ${recipents}");
                  _sendSMS(message, recipents);
                },
                buttonColor: color1,
                text: 'sms',
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: unVotedFoll.length,
                    itemBuilder: (context, index) {
                      return Container(
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
                              offset: Offset(0, 3),
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Center(
                              child: LocalizedText(
                                '${unVotedFoll[index]['first_name']} ${unVotedFoll[index]['second_name']} ${unVotedFoll[index]['last_name']}',
                                style: GoogleFonts.cairo(
                                  color: color1,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // Row(
                            //   children: [
                            //     LocalizedText(
                            //       'phone',
                            //       style: GoogleFonts.cairo(
                            //         color: black,
                            //         fontSize: 14.sp,
                            //       ),
                            //     ),
                            //     LocalizedText(
                            //       ': ${unVotedFoll[index]['phone'] == null ? "" : unVotedFoll[index]['phone']}',
                            //       style: GoogleFonts.cairo(
                            //         color: black,
                            //         fontSize: 14.sp,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            Row(
                              children: [
                                LocalizedText(
                                  'ID',
                                  style: GoogleFonts.cairo(
                                    color: black,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                LocalizedText(
                                  ' :  ${unVotedFoll[index]['idc']}',
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
                                  'voternumm',
                                  style: GoogleFonts.cairo(
                                    color: black,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                Text(
                                  ' : ${unVotedFoll[index]['voter_number']}',
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
                                  'boxid',
                                  style: GoogleFonts.cairo(
                                    color: black,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                LocalizedText(
                                  ' :  ${unVotedFoll[index]['box']['box_number']}',
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
                                  'boxaddress',
                                  style: GoogleFonts.cairo(
                                    color: black,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                Text(
                                  ' : ${unVotedFoll[index]['box']['box_address']}',
                                  style: GoogleFonts.cairo(
                                    color: black,
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
