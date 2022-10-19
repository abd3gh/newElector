import 'package:elector/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';

import '../../../../api/api_controllers/controllers.dart';

class ViewVotedFollower extends StatefulWidget {
  dynamic followerlist;

  ViewVotedFollower({Key? key, this.followerlist}) : super(key: key);

  @override
  State<ViewVotedFollower> createState() => _ViewVotedFollowerState();
}

class _ViewVotedFollowerState extends State<ViewVotedFollower> {
  var followerslist;

  var voted;
  bool isloading = false;
  List<dynamic> votedFollower = [];

  getelectors() async {
    isloading = true;
    setState(() {});
    await ApiControllers().getfollowers().then((value) => {
          followerslist = value['data'],
          for (int i = 0; i < followerslist.length; i++)
            {
              if (followerslist[i]['voted'] == null)
                {}
              else
                {
                  if (followerslist[i]['voted'] == 0) {} else {votedFollower.add(followerslist[i])}
                }
            }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: LocalizedText(
          'votedfollowers',
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
          : ListView.builder(
              itemCount: votedFollower.length,
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
                          '${votedFollower[index]['first_name']} ${votedFollower[index]['second_name']} ${votedFollower[index]['last_name']}',
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
                      //         color: color1,
                      //         fontSize: 14.sp,
                      //       ),
                      //     ),
                      //     LocalizedText(
                      //       ': ${votedFollower[index]['phone'] == null ? "" : votedFollower[index]['phone']}',
                      //       style: GoogleFonts.cairo(
                      //         color: color1,
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
                            ' :  ${votedFollower[index]['idc']}',
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
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            ' : ${votedFollower[index]['voter_number']}',
                            style: GoogleFonts.cairo(
                              color: black,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          LocalizedText(
                            'boxid',
                            style: GoogleFonts.cairo(
                              color: color1,
                              fontSize: 14.sp,
                            ),
                          ),
                          LocalizedText(
                            ' :  ${votedFollower[index]['box']['box_number']}',
                            style: GoogleFonts.cairo(
                              color: color1,
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
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            ' : ${votedFollower[index]['box']['box_address']}',
                            style: GoogleFonts.cairo(
                              color: black,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
    );
  }
}
// Text(
// '${search[index]['full_name']}',
// style: GoogleFonts.cairo(
// color: color4,
// fontSize: 14.sp,
// ),
// ),
