import 'dart:ffi';

import 'package:elector/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';

import '../../api/api_controllers/controllers.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as sync;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:convert';

class ShowElector extends StatefulWidget {
  const ShowElector({Key? key}) : super(key: key);

  @override
  State<ShowElector> createState() => _ShowElectorState();
}

class _ShowElectorState extends State<ShowElector> {
  var electorslist = [];

  List names = [];
  List voterNumber = [];
  List boxNumber = [];
  bool isloading = false;

  getelectors() async {
    isloading = true;
    setState(() {});
    await ApiControllers().getBoxVoters().then((value) => {
          if (value["status"] != "error")
            {
              electorslist = value['data'],

              names = electorslist.map((e) => '${e['first_name']} ${e['second_name']} ${e['last_name']}').toList(),
              voterNumber = electorslist.map((e) => e['voter_number']).toList(),
              boxNumber = electorslist.map((e) => e['box']['box_number']).toList(),
            }
        });

    isloading = false;
    setState(() {});

    print("my activitists are $electorslist");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getelectors();
  }

  Future<void> createExcel() async {
    final sync.Workbook workbook = sync.Workbook();
    final sync.Worksheet sheet = workbook.worksheets[0];

    for (int i = 0; i < names.length; i++) {
      sheet.getRangeByName('A${i + 1}').setText('${names[i]}');
      sheet.getRangeByName('B${i + 1}').setText('${voterNumber[i]}');
      sheet.getRangeByName('C${i + 1}').setText('${boxNumber[i]}');
    }
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    if (kIsWeb) {
      AnchorElement(href: 'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
        ..setAttribute('download', 'Output.xlsx')
        ..click();
    } else {
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName = Platform.isWindows ? '$path\\Output.xlsx' : '$path/Output.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: LocalizedText('votersss',
            style: GoogleFonts.cairo(
              color: color1,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
        backgroundColor: white,
        actions: [
          GestureDetector(
            onTap: () {
              createExcel();
            },
            child: Chip(
              label: LocalizedText('print'),
            ),
          )
        ],
      ),
      body: isloading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
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
                      color: Colors.white,
                      width: 1.w,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LocalizedText(
                        'name',
                        style: GoogleFonts.cairo(
                          color: color1,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      LocalizedText(
                        'voternumm',
                        style: GoogleFonts.cairo(
                          color: white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      LocalizedText(
                        'voternumm',
                        style: GoogleFonts.cairo(
                          color: color1,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      LocalizedText(
                        'boxid',
                        style: GoogleFonts.cairo(
                          color: color1,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: electorslist.length,
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
                              color: Colors.white,
                              width: 1.w,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LocalizedText(
                                '${electorslist[index]['first_name']} ${electorslist[index]['second_name']} ${electorslist[index]['last_name']}',
                                style: GoogleFonts.cairo(
                                  color: black,
                                  fontSize: 14.sp,
                                ),
                              ),
                              LocalizedText(
                                '${electorslist[index]['voter_number']}',
                                style: GoogleFonts.cairo(
                                  color: black,
                                  fontSize: 14.sp,
                                ),
                              ),
                              LocalizedText(
                                '${electorslist[index]['box']['box_number']}',
                                style: GoogleFonts.cairo(
                                  color: black,
                                  fontSize: 14.sp,
                                ),
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
