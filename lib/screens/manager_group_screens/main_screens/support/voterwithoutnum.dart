import 'package:elector/api/api_controllers/controllers.dart';
import 'package:elector/constants.dart';
import 'package:elector/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

class VoterWithoutNumScreen extends StatefulWidget {
  const VoterWithoutNumScreen({Key? key}) : super(key: key);

  @override
  State<VoterWithoutNumScreen> createState() => _VoterWithoutNumScreenState();
}

class _VoterWithoutNumScreenState extends State<VoterWithoutNumScreen> {
  bool isloading = false;
  bool _isVisible = true;
  bool sisloading = false;
  List listofcontacts = [];
  var orginalList;
  final _cont = TextEditingController();
  int searchOption = 0;
  int page = 1;
  Future search() async {
    page = 1;
    isloading = true;
    setState(() {});
    await ApiControllers()
        .searchNonContacts(getSearchBody(), page)
        .then((value) => {
              contactwithoutNumlist = value['data']['data'],
            });
    isloading = false;
    setState(() {});
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

  sendcontacts() async {
    isloading = true;
    setState(() {});
    // Request contact permission
    if (await FlutterContacts.requestPermission()) {
      // Get all contacts (lightly fetched)
      List<Contact> contacts;
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);

      for (int i = 0; i < contacts.length; i++) {
        try {
          listofcontacts.add(
            {
              "user_id": 2,
              "name": contacts[i].displayName,
              "phone": contacts[i].phones[0].number
            },
          );
        } catch (e) {}
      }
      print(listofcontacts);
    }

    isloading = false;
    setState(() {});
  }

  bool canLoad = true;
  getMore() async {
    sisloading = true;
    setState(() {});
    if (canLoad) {
      canLoad = false;
      await ApiControllers()
          .getcontacts("voters?page=${page}")
          .then((value) => {
                contactwithoutNumlist = [
                  ...contactwithoutNumlist,
                  ...value['data']['data']
                ],
              });
      setState(() {});

      print("my contactlist are $contactlist");
      await Provider.of<EventProvider>(context, listen: false)
          .getSavedWithData();
      canLoad = true;
      sisloading = false;
      setState(() {});
    }
  }

  getMoreSearch() async {
    sisloading = true;
    setState(() {});
    if (canLoad) {
      canLoad = false;
      sisloading = true;
      setState(() {});
      await ApiControllers()
          .searchNonContacts(getSearchBody(), page)
          .then((value) => {
                // contactwithoutNumlist = value['data']['data'],
                contactwithoutNumlist = [
                  ...contactwithoutNumlist,
                  ...value['data']['data']
                ],
              });
      sisloading = false;

      canLoad = true;
      setState(() {});
    }
  }

  List contactlist = [];
  List contactwithoutNumlist = [];
  bool _correct = false;
  // getcontacts() async {
  //   isloading = true;
  //   page = 1;
  //   setState(() {});
  //   await ApiControllers()
  //       .getcontacts("contacts/matchPages?page=${page}")
  //       .then((value) => {
  //     contactlist = value['data']['data'],
  //   });
  //   isloading = false;
  //   setState(() {});
  //
  //   print("my contactlist are $contactlist");
  //   Provider.of<EventProvider>(context, listen: false).getSavedWithData();
  // }
  getcontactswithoutNum() async {
    isloading = true;
    page = 1;
    setState(() {});
    await ApiControllers().getcontacts("voters?page=${page}").then((value) {
      print(value);
      print("value");

      contactwithoutNumlist = value['data']['data'] ?? [];
    });
    isloading = false;

    setState(() {});

    print("my contactlist are $contactwithoutNumlist");
    Provider.of<EventProvider>(context, listen: false).getSavedData();
    Provider.of<EventProvider>(context, listen: false).getSavedFollowerData();
  }

  @override
  void initState() {
    super.initState();
    _cont.addListener(() async {
      await Duration(milliseconds: 300);
      if (_cont.text.isNotEmpty) {
        await search();
      } else {
        await getcontactswithoutNum();
      }
    });
    // .distinct()
    // .debounceTime(const Duration(milliseconds: 300))
    // .listen((event) => loadNearbyDeals());
    getcontactswithoutNum();
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
          'votersss',
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
                          //   return await getcontactswithoutNum();
                          // }
                          //
                          // search();
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
                      Text('${contactwithoutNumlist.length}'),
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
                    setState(() {});
                    getcontactswithoutNum();
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
                ? const Center(child: CircularProgressIndicator())
                : LazyLoadScrollView(
                    onEndOfPage: () async {
                      page++;
                      if (_cont.text.isEmpty) {
                        await getMore();
                      } else {
                        await getMoreSearch();
                      }
                    },
                    scrollOffset: 100,
                    isLoading: sisloading,
                    scrollDirection: Axis.horizontal,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: contactwithoutNumlist.length,
                        itemBuilder: (context, index) {
                          var data = contactwithoutNumlist[index];
                          return Container(
                            alignment: Alignment.center,
                            width: 250.w,
                            margin: EdgeInsets.only(
                              left: 10.w,
                              right: 10.w,
                              bottom: 120.w,
                              // vertical: 120.h,
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
                                    alignment: Alignment.topLeft,
                                    child: IconButton(
                                      icon: Icon(Provider.of<EventProvider>(
                                        context,
                                      ).saved.contains(data['idc'].toString())
                                          ? Icons.check_box
                                          : Icons.check_box_outline_blank),
                                      onPressed: () => {
                                        setState(() {
                                          print("ds");
                                          if (Provider.of<EventProvider>(
                                                  context,
                                                  listen: false)
                                              .saved
                                              .contains(
                                                data['idc'].toString(),
                                              )) {
                                            Provider.of<EventProvider>(context,
                                                    listen: false)
                                                .deleteSavedData(
                                              data['idc'].toString(),
                                            );
                                          } else {
                                            Provider.of<EventProvider>(context,
                                                    listen: false)
                                                .addSaveToList(
                                              data['idc'].toString(),
                                            );
                                          }
                                          _correct = !_correct;
                                          // data
                                          //saveGreen();  //??
                                        })
                                      },
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
                                  //     LocalizedText(
                                  //       '',
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
                                          color: black,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      Text(
                                        '  ${data["box"]?['id']}  ',
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
                                        setState(() {
                                          Provider.of<EventProvider>(context,
                                                  listen: false)
                                              .addSaveFollowerToList(
                                            data['idc'].toString(),
                                          );
                                          // }
                                          _isVisible = false;
                                        });
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
              color: color1,
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
// IconButton(
// onPressed: () {
// showModalBottomSheet(
// isScrollControlled: true,
// backgroundColor: Colors.transparent,
// context: context,
// builder: (context) =>
// const SupportOptionScreen(),
// );
// // builder: (context) => AddVisitorComment(),
// // );
// },
// icon: Icon(
// Icons.more_vert,
// color: color1,
// ),
// ),
