import 'package:elector/constants.dart';
import 'package:elector/screens/manager_group_screens/main_screens/follower/follower_option_screen.dart';
import 'package:elector/screens/manager_group_screens/main_screens/follower/unvoted_follower.dart';
import 'package:elector/screens/manager_group_screens/main_screens/follower/view_voted_follower.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../../../api/api_controllers/controllers.dart';

class FollowerScreen extends StatefulWidget {
  const FollowerScreen({Key? key}) : super(key: key);

  @override
  State<FollowerScreen> createState() => _FollowerScreenState();
}

class _FollowerScreenState extends State<FollowerScreen> {
  final _cont = TextEditingController();
  var followerslist;
  var orginalList;
  int searchOption = 0;
  List<String> search = [];
  bool isloading = false;
  var len = 0.0;
  List<int> iscolor = [];

  getelectors() async {
    isloading = true;
    setState(() {});
    await ApiControllers().getfollowers().then((value) => {
          followerslist = value['data'],
          print(followerslist),
          orginalList = value['data'],
          print(orginalList.length),
          len = followerslist.length / 10.0,
          for (int i = 0; i < followerslist.length; i++)
            {
              if (followerslist[i]['phone'] == null) {} else {search.add(followerslist[i]['phone'])}
            },
          for (int i = 0; i < orginalList.length; i++)
            {
              if (orginalList[i]['phone'] == null) {} else {search.add(orginalList[i]['phone'])}
            },
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
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              appBar: AppBar(
                backgroundColor: white,
                centerTitle: true,
                title: LocalizedText(
                  'followers',
                  style: GoogleFonts.cairo(
                    color: color1,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                  horizontal: 25.w,
                  vertical: 15.h,
                ),
                child: Column(
                  children: [
                    Center(
                      child: RatingBar.builder(
                        minRating: 1,
                        ignoreGestures: true,
                        initialRating: double.parse(len.toString().split(" ")[0]),
                        onRatingUpdate: (rating) {
                          setState(() {});
                        },
                        itemSize: 28.w,
                        itemCount: 10,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: color2,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            onPrimary: color2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            minimumSize: Size(90.w, 30.h),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => ViewVotedFollower()),
                              ),
                            );
                          },
                          child: LocalizedText(
                            'showvotedfollowers',
                            textScaleFactor: 1,
                            style: GoogleFonts.cairo(
                              color: white,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            onPrimary: color2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            minimumSize: Size(90.w, 30.h),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => UnVotedFollower()),
                              ),
                            );
                          },
                          child: LocalizedText(
                            'showunvotedfollowers',
                            textScaleFactor: 1,
                            style: GoogleFonts.cairo(
                              color: white,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            elevation: 5,
                            child: Container(
                              height: 40,
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              // width: 192,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: TextField(
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(bottom: 10),
                                        border: InputBorder.none,
                                        hintText: KLocalizations.of(context).translate('searchHere')),
                                    controller: _cont,
                                    onChanged: (e) {
                                      print(orginalList);

                                      if (searchOption == 0) {
                                        followerslist = orginalList
                                            .where((element) => element["first_name"].toString().contains(e))
                                            .toList();
                                      } else if (searchOption == 1) {
                                        followerslist = orginalList
                                            .where((element) => element["idc"].toString().contains(e))
                                            .toList();
                                      } else if (searchOption == 2) {
                                        followerslist = orginalList
                                            .where((element) => element["last_name"].toString().contains(e))
                                            .toList();
                                      } else {
                                        followerslist = orginalList
                                            .where((element) => element["phone"].toString().contains(e))
                                            .toList();
                                      }
                                      setState(() {});
                                    },
                                  )),
                                  GestureDetector(
                                      onTap: () {
                                        showDialog<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: StatefulBuilder(
                                                builder: (BuildContext context, StateSetter setState1) {
                                                  return Column(mainAxisSize: MainAxisSize.min, children: [
                                                    LocalizedText(
                                                      'searchOption',
                                                      style: GoogleFonts.cairo(
                                                        color: Color(0xFF520000),
                                                        fontSize: 14.sp,
                                                      ),
                                                    ),
                                                    _buildSearchOption(0, searchOption, 'firstName', () {
                                                      setState1(() {});
                                                    }),
                                                    _buildSearchOption(
                                                      1,
                                                      searchOption,
                                                      "identityNumber",
                                                      () {
                                                        setState1(() {});
                                                      },
                                                    ),
                                                    _buildSearchOption(2, searchOption, "familyName", () {
                                                      setState1(() {});
                                                    }),
                                                    _buildSearchOption(3, searchOption, "phoneNumber", () {
                                                      setState1(() {});
                                                    })
                                                  ]);
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Image.asset('assets/refreash.png')),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(20),
                          elevation: 5,
                          child: Container(
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text('${followerslist.length}'),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.people),
                                SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(20),
                          elevation: 5,
                          child: GestureDetector(
                            onTap: () {
                              _cont.text = "";
                              followerslist = orginalList;
                              setState(() {});
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Image.asset('assets/reload.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    PieChart(
                      dataMap: {
                        "مصوت": followerslist.where((i) => i['voted'] == 1).toList().length.toDouble(),
                        "غير مصوت": followerslist.where((i) => i['voted'] != 1).toList().length.toDouble(),
                      },
                      animationDuration: Duration(milliseconds: 800),
                      chartLegendSpacing: 1,
                      chartRadius: MediaQuery.of(context).size.width / 4.5,
                      colorList: [Colors.green, Colors.red],
                      initialAngleInDegree: 5,
                      chartType: ChartType.ring,
                      // ringStrokeWidth: 32,
                      // centerText: "HYBRID",
                      chartValuesOptions: ChartValuesOptions(
                        showChartValueBackground: true,
                        showChartValues: true,
                        showChartValuesInPercentage: false,
                        showChartValuesOutside: false,
                        decimalPlaces: 1,
                      ),
                      // gradientList: ---To add gradient colors---
                      // emptyColorGradient: ---Empty Color gradient---
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: followerslist.length,
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
                                color: followerslist[index]['followerMarked'] == 1 ||iscolor.contains(followerslist[index]['id']) ? Colors.greenAccent : white,
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
                                  IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (context) => FollowerOptionScreen(followerlist: followerslist[index]),
                                      ).then((value) => {getelectors()});
                                      // );
                                    },
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: color1,
                                    ),
                                  ),
                                  Center(
                                    child: LocalizedText(
                                      '${followerslist[index]['first_name']} ${followerslist[index]['second_name']} ${followerslist[index]['last_name']}',
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
                                  //       '   ${followerslist[index]['phone'] == null ? '' : followerslist[index]['phone']}  ',
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
                                        '   ${followerslist[index]['idc']}  ',
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
                                      LocalizedText(
                                        '   ${followerslist[index]['voter_number']}  ',
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
                                        '   ${followerslist[index]['box']['box_number']}  ',
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
                                      Expanded(
                                        child: LocalizedText(
                                          '${followerslist[index]['box']['box_address']}',
                                          style: GoogleFonts.cairo(
                                            color: black,
                                            fontSize: 14.sp,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      LocalizedText(
                                        '${followerslist[index]['voted'] == 1 ? 'voted' : 'notvoted'}',
                                        style: GoogleFonts.cairo(
                                          color: followerslist[index]['voted'] == 1 ? Colors.green : Colors.blue,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: color1,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8.r),
                                          ),
                                          minimumSize: Size(80.w, 24.h),
                                        ),
                                        onPressed: () async {
                                          print(followerslist[index]['id']);
                                          iscolor.add(followerslist[index]['id']);
                                          setState(() {});
                                          print(iscolor);
                                          print("iscolor");
                                          await ApiControllers().followersHaveBeenContacted(id: followerslist[index]['id']);
                                         // getelectors();
                                        },
                                        child: LocalizedText(
                                          'تم التواصل',
                                          style: GoogleFonts.cairo(
                                            color: white,
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
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
              ),
            ),
    );
  }

  Row _buildSearchOption(int index, int selectedRadio, String text, Function setState1) {
    return Row(
      children: [
        Radio<int>(
          value: index,
          groupValue: selectedRadio,
          focusColor: Color(0xFF520000),
          activeColor: Color(0xFF520000),
          onChanged: (x) {
            print(x);
            searchOption = x!;
            setState1();
            Navigator.of(context).pop();
          },
        ),
        LocalizedText(
          text,
          style: GoogleFonts.cairo(
            color: Color(0xFF520000),
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}
