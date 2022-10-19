import 'package:elector/constants.dart';
import 'package:elector/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../../../api/api_controllers/controllers.dart';

class ActivistScreen extends StatefulWidget {
  const ActivistScreen({Key? key}) : super(key: key);

  @override
  State<ActivistScreen> createState() => _ActivistScreenState();
}

class _ActivistScreenState extends State<ActivistScreen> {
  final _cont = TextEditingController();
  String message = "hi";
  List<String> recipents = [];
  var orginalList;
  int searchOption = 0;
  var activitistlist;
  bool isloading = false;
  int days = 0;
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  int fllowNum = 0;
  int unfllowNum = 0;

  getactivist() async {
    isloading = true;
    setState(() {});
    await ApiControllers().getactivists().then((value) {
      activitistlist = value['data'];
      orginalList = value['data'];
      print(value['data']);
      activitistlist.forEach((element) {
        recipents.add(element['phone']);
        print("my activitists are dfes $recipents");
        fllowNum += int.parse(element['followersCount'].toString());
        unfllowNum += int.parse(element['voters_count'].toString());
      });
      orginalList.forEach((element) {
        recipents.add(element['phone']);
        print("my activitists are dfes $recipents");
        // fllowNum += int.parse(element['followersCount'].toString());
        // unfllowNum += int.parse(element['voters_count'].toString());
      });
    });

    await ApiControllers().getSetting().then((value) {
      DateTime dt1 = DateTime.parse(DateTime.now().toString());
      DateTime dt2 = DateTime.parse(value['data']['time']);
      Duration diff = dt1.difference(dt2);

      if (!(daysBetween(dt1, dt2) < 0)) {
        days = daysBetween(dt1, dt2);
        hours = diff.inHours;
        minutes = diff.inMinutes;
        seconds = diff.inSeconds;
      }
    });

    isloading = false;
    setState(() {});

    // print("my activitists are $activitistlist");
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print("fdd ${_result}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getactivist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LocalizedText(
          'activist',
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
              margin: EdgeInsets.symmetric(horizontal: 25.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  WidgetButton(
                    onPress: () async {
                      print("gggg ${recipents}");
                      _sendSMS(message, recipents);
                    },
                    buttonColor: color1,
                    text: 'sms',
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Column(
                    children: [
                      // LocalizedText(
                      //   ' الوقت المتبقي للانتخابات',
                      //   style: GoogleFonts.cairo(
                      //     color: color1,
                      //     fontSize: 14.sp,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Column(
                      //       children: [
                      //         Text(
                      //           '$days',
                      //           style: GoogleFonts.cairo(
                      //             color: color1,
                      //             fontSize: 16.sp,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //         LocalizedText(
                      //           'day',
                      //           style: GoogleFonts.cairo(
                      //             color: color1,
                      //             fontSize: 16.sp,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //     Column(
                      //       children: [
                      //         Text(
                      //           '$hours',
                      //           style: GoogleFonts.cairo(
                      //             color: color1,
                      //             fontSize: 16.sp,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //         LocalizedText(
                      //           'hr',
                      //           style: GoogleFonts.cairo(
                      //             color: color1,
                      //             fontSize: 16.sp,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //     Column(
                      //       children: [
                      //         Text(
                      //           '$minutes',
                      //           style: GoogleFonts.cairo(
                      //             color: color1,
                      //             fontSize: 16.sp,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //         LocalizedText(
                      //           'min',
                      //           style: GoogleFonts.cairo(
                      //             color: color1,
                      //             fontSize: 16.sp,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //     Column(
                      //       children: [
                      //         Text(
                      //           '$seconds',
                      //           style: GoogleFonts.cairo(
                      //             color: color1,
                      //             fontSize: 16.sp,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //         LocalizedText(
                      //           'sec',
                      //           style: GoogleFonts.cairo(
                      //             color: color1,
                      //             fontSize: 16.sp,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),

                      PieChart(
                        dataMap: {
                          "التابعين": fllowNum.toDouble(),
                          "الناخبين": unfllowNum.toDouble(),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(20),
                            elevation: 5,
                            child: Container(
                              height: 40,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: TextField(
                                    decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(bottom: 10),
                                        border: InputBorder.none,
                                        hintText: KLocalizations.of(context)
                                            .translate('searchHere')),
                                    controller: _cont,
                                    onChanged: (e) {
                                      print(orginalList);
                                      if (searchOption == 0) {
                                        activitistlist = orginalList
                                            .where((element) =>
                                                element["first_name"]
                                                    .toString()
                                                    .contains(e))
                                            .toList();
                                      } else if (searchOption == 1) {
                                        activitistlist = orginalList
                                            .where((element) => element["idc"]
                                                .toString()
                                                .contains(e))
                                            .toList();
                                      } else if (searchOption == 2) {
                                        activitistlist = orginalList
                                            .where((element) =>
                                                element["last_name"]
                                                    .toString()
                                                    .contains(e))
                                            .toList();
                                      } else {
                                        activitistlist = orginalList
                                            .where((element) => element["phone"]
                                                .toString()
                                                .contains(e))
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
                                                builder: (BuildContext context,
                                                    StateSetter setState1) {
                                                  return Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        LocalizedText(
                                                          'searchOption',
                                                          style:
                                                              GoogleFonts.cairo(
                                                            color: Color(
                                                                0xFF520000),
                                                            fontSize: 14.sp,
                                                          ),
                                                        ),
                                                        _buildSearchOption(
                                                            0,
                                                            searchOption,
                                                            'firstName', () {
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
                                                        _buildSearchOption(
                                                            2,
                                                            searchOption,
                                                            "familyName", () {
                                                          setState1(() {});
                                                        }),
                                                        _buildSearchOption(
                                                            3,
                                                            searchOption,
                                                            "phoneNumber", () {
                                                          setState1(() {});
                                                        })
                                                      ]);
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child:
                                          Image.asset('assets/refreash.png')),
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
                            child: Container(
                              height: 40,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('${activitistlist.length}'),
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
                                activitistlist = orginalList;
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
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: activitistlist.length,
                        itemBuilder: (context, index) {
                          var values = activitistlist[index];
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
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: PopupMenuButton<int>(
                                    padding: EdgeInsets.zero,
                                    color: white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: color3,
                                    ),
                                    iconSize: 24,
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        height: 25.h,
                                        value: 1,
                                        child: InkWell(
                                          onTap: () {
                                            launchUrl(
                                              Uri.parse(
                                                  "sms://${values['phone']}"),
                                            );
                                          },
                                          child: Center(
                                            child: LocalizedText(
                                              'sms',
                                              style: GoogleFonts.cairo(
                                                color: color1,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      PopupMenuDivider(),
                                      PopupMenuItem(
                                        height: 25.h,
                                        value: 1,
                                        child: InkWell(
                                          onTap: () {
                                            launchUrl(
                                              Uri.parse(
                                                  "tel://${values['phone']}"),
                                            );
                                          },
                                          child: Center(
                                            child: LocalizedText(
                                              'call',
                                              style: GoogleFonts.cairo(
                                                color: color1,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      PopupMenuDivider(),
                                      PopupMenuItem(
                                        height: 25.h,
                                        value: 1,
                                        child: InkWell(
                                          onTap: () async {
                                            await launch('${WhatsAppUnilink(
                                              phoneNumber: '${values['phone']}',
                                              text: "",
                                            )}');
                                          },
                                          child: Center(
                                            child: LocalizedText(
                                              'whatsapp',
                                              style: GoogleFonts.cairo(
                                                color: color1,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    '${values['fullname']}',
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
                                //     Text(
                                //       '  ${values['phone']} ',
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
                                      '  ${values['idc']} ',
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
                                      'followernum',
                                      style: GoogleFonts.cairo(
                                        color: black,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    LocalizedText(
                                      '  ${values['followersCount']} ',
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
                                      'voternum',
                                      style: GoogleFonts.cairo(
                                        color: black,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    LocalizedText(
                                      '  ${values['voters_count']} ',
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
            ),
    );
  }

  Row _buildSearchOption(
      int index, int selectedRadio, String text, Function setState1) {
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
