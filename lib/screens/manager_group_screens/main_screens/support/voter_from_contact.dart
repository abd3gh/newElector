import 'package:elector/api/api_controllers/controllers.dart';
import 'package:elector/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../provider/event_provider.dart';

class VoterFromContact extends StatefulWidget {
  const VoterFromContact({Key? key}) : super(key: key);

  @override
  State<VoterFromContact> createState() => _VoterFromContactState();
}

class _VoterFromContactState extends State<VoterFromContact> {
  bool isloading = false;
  bool sisloading = false;
  List contactlist = [];
  bool _isVisible = true;
  bool _correct = false;
  List orginalList = [];
  final _cont = TextEditingController();
  int searchOption = 0;
  int page = 1;

  Future search() async {
    isloading = true;
    setState(() {});
    await ApiControllers().searchContacts(getSearchBody()).then((value) => {
          contactlist = value['data'],
        });
    isloading = false;
    setState(() {});
  }

  getcontacts() async {
    isloading = true;
    page = 1;
    setState(() {});
    await ApiControllers()
        .getcontacts("contacts/matchPages?page=${page}")
        .then((value) => {
              contactlist = value['data']['data'],
            });
    isloading = false;
    setState(() {});

    print("my contactlist are $contactlist");
    Provider.of<EventProvider>(context, listen: false).getSavedWithData();
  }

  Map getSearchBody() {
    Map search = {};
    if (searchOption == 0) {
      search["first_name"] = _cont.text;
    } else if (searchOption == 1) {
      search["idc"] = _cont.text;
    } else if (searchOption == 2) {
      search["last_name"] = _cont.text;
    } else {
      search["phone"] = _cont.text;
    }
    return search;
  }

  bool canLoad = true;
  getMore() async {
    sisloading = true;
    setState(() {});
    if (canLoad) {
      canLoad = false;
      await ApiControllers()
          .getcontacts("contacts/matchPages?page=${page}")
          .then((value) => {
                contactlist = [...contactlist, ...value['data']['data']],
              });
      // isloading = false;
      setState(() {});

      print("my contactlist are $contactlist");
      await Provider.of<EventProvider>(context, listen: false)
          .getSavedWithData();
      canLoad = true;
      sisloading = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _cont.addListener(() async {
      await Duration(milliseconds: 300);
      if (_cont.text.isNotEmpty) {
        await search();
      } else {
        await getcontacts();
      }
    });
    getcontacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: color1,
        ),
        backgroundColor: white,
        centerTitle: true,
        title: LocalizedText(
          'ناخبين جهات الاتصال ',
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
            color: color1,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 5,
                child: Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                            contentPadding: EdgeInsets.only(bottom: 10),
                            border: InputBorder.none,
                            hintText: KLocalizations.of(context)
                                .translate('searchHere')),
                        controller: _cont,
                        onChanged: (e) async {
                          // if (_cont.text.isEmpty) {
                          //   return await getcontacts();
                          // }

                          // search();
                          // print(orginalList);
                          //
                          // if (searchOption == 0) {
                          //   contactlist = orginalList
                          //       .where((element) => element["first_name"]
                          //           .toString()
                          //           .contains(e))
                          //       .toList();
                          // } else if (searchOption == 1) {
                          //   contactlist = orginalList
                          //       .where((element) =>
                          //           element["idc"].toString().contains(e))
                          //       .toList();
                          // } else if (searchOption == 2) {
                          //   contactlist = orginalList
                          //       .where((element) => element["last_name"]
                          //           .toString()
                          //           .contains(e))
                          //       .toList();
                          // } else {
                          //   contactlist = orginalList
                          //       .where((element) => element["phone"]
                          //           .toString()
                          //           .contains(e))
                          //       .toList();
                          // }
                          // setState(() {});
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
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            LocalizedText(
                                              'searchOption',
                                              style: GoogleFonts.cairo(
                                                color: Color(0xFF520000),
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                            _buildSearchOption(
                                                0, searchOption, 'firstName',
                                                () {
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
                                                2, searchOption, "familyName",
                                                () {
                                              setState1(() {});
                                            }),
                                            _buildSearchOption(
                                                3, searchOption, "phoneNumber",
                                                () {
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
                      Text('${contactlist.length}'),
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
                    getcontacts();
                    // setState(() {});
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
            height: 40,
          ),
          Expanded(
            child: isloading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : LazyLoadScrollView(
                    onEndOfPage: () async {
                      if (_cont.text.isEmpty) {
                        page++;
                        await getMore();
                      }
                    },
                    scrollOffset: 100,
                    isLoading: sisloading,
                    scrollDirection: Axis.horizontal,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: contactlist.length,
                        itemBuilder: (context, index) {
                          var data = contactlist[index];
                          return Container(
                            alignment: Alignment.center,
                            width: 250.w,
                            margin: EdgeInsets.only(
                              left: 10.w,
                              right: 10.w,
                              bottom:
                                  MediaQuery.of(context).viewInsets.bottom == 0
                                      ? 120.h
                                      : 0.h,
                              top: 50.h,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                              vertical: 15.h,
                            ),
                            decoration: BoxDecoration(
                              color: white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(0, 3),
                                )
                              ],
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.end,
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
                                                    "sms://${data['phone']}"),
                                              );
                                            },
                                            child: Center(
                                              child: Text(
                                                'رسالة',
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
                                                    "tel://${data['phone']}"),
                                              );
                                            },
                                            child: Center(
                                              child: Text(
                                                'مكالمة',
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
                                  Text(
                                    '${data['first_name']} ${data['second_name']} ${data['last_name']}',
                                    style: GoogleFonts.cairo(
                                      color: color1,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   children: [
                                  //     LocalizedText(
                                  //       'phone',
                                  //       style: GoogleFonts.cairo(
                                  //         color: black,
                                  //         fontSize: 14.sp,
                                  //       ),
                                  //     ),
                                  //     Text(
                                  //       '  ${data['phone']}  ',
                                  //       style: GoogleFonts.cairo(
                                  //         color: black,
                                  //         fontSize: 14.sp,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      LocalizedText(
                                        'ID',
                                        style: GoogleFonts.cairo(
                                          color: black,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      Text(
                                        '  ${data['idc']}  ',
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
                                        '  ${data['voter_number']}  ',
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
                                      Text(
                                        '  ${data['box']?['id']}  ',
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
                                        child: Text(
                                          '  ${data['box']?['box_address']}  ',
                                          style: GoogleFonts.cairo(
                                            color: black,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  LocalizedText(
                                    '${data['voted'] == 1 ? 'voted' : 'notvoted'}',
                                    style: GoogleFonts.cairo(
                                      color: data['voted'] == 1
                                          ? Colors.green
                                          : Colors.blue,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Visibility(
                                    visible: true,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: color1,
                                        onPrimary: color2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                        ),
                                        minimumSize: Size(100.w, 35.h),
                                      ),
                                      onPressed: () async {
                                        await ApiControllers().addfollowers(
                                            voters_id: data['id']);
                                        showAlertDialog(context);
                                        setState(() {});
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'إضافة كتابع',
                                            style: GoogleFonts.cairo(
                                              color: white,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Image.asset(
                                            'assets/like.png',
                                            color: white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Provider.of<EventProvider>(
                                        context,
                                      )
                                              .savedWith
                                              .contains(data['idc'].toString())
                                          ? Colors.grey
                                          : color1,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                      ),
                                      minimumSize: Size(100.w, 35.h),
                                    ),
                                    child: LocalizedText(
                                      Provider.of<EventProvider>(
                                        context,
                                      ).saved.contains(data['idc'].toString())
                                          ? 'done'
                                          : 'save',
                                      style: GoogleFonts.cairo(),
                                    ),
                                    onPressed: () => {
                                      setState(() {
                                        if (Provider.of<EventProvider>(context,
                                                listen: false)
                                            .savedWith
                                            .contains(data['idc'].toString())) {
                                          Provider.of<EventProvider>(context,
                                                  listen: false)
                                              .deleteSavedWithData(
                                                  data['idc'].toString());
                                        } else {
                                          Provider.of<EventProvider>(context,
                                                  listen: false)
                                              .addSaveWithToList(
                                                  data['idc'].toString());
                                        }
                                        _correct = !_correct;
                                        // data
                                        //saveGreen();  //??
                                      })
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
          ),
        ],
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

  showAlertDialog(BuildContext context) {
    Widget continueButton = Center(
      child: TextButton(
          child: LocalizedText(
            "addeddone",
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
