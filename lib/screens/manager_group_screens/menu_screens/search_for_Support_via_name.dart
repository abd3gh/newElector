import 'package:elector/constants.dart';
import 'package:elector/widgets/app_text_feild.dart';
import 'package:elector/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../api/api_controllers/controllers.dart';

class SearchSupportViaName extends StatefulWidget {
  const SearchSupportViaName({Key? key}) : super(key: key);

  @override
  State<SearchSupportViaName> createState() => _SearchSupportViaNameState();
}

class _SearchSupportViaNameState extends State<SearchSupportViaName> {
  late TextEditingController _nameTextEditingController;
  bool isloading = false;
  @override
  void initState() {
    _nameTextEditingController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameTextEditingController.dispose();
  }

  var results;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: color1,
        ),
        title: LocalizedText(
          'بحث بواسطة الاسم',
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
            fontSize: 17.sp,
            color: color1,
          ),
        ),
        centerTitle: true,
        backgroundColor: white,
        elevation: 0,
      ),
      body: ModalProgressHUD(
        inAsyncCall: isloading,
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 25.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LocalizedText(
                'ادخل الاسم',
                style: GoogleFonts.cairo(
                  color: color1,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              AppTextField(
                textEditingController: _nameTextEditingController,
              ),
              SizedBox(
                height: 15.h,
              ),
              WidgetButton(
                onPress: () async {
                  isloading = true;
                  setState(() {});
                  await ApiControllers()
                      .searchfollower(_nameTextEditingController.text.trim())
                      .then((value) => {results = value['data']});

                  isloading = false;
                  setState(() {});
                },
                text: 'بحث',
                buttonColor: color2,
              ),
              SizedBox(
                height: 15.h,
              ),
              results == null || results.isEmpty
                  ? Center(
                      child: LocalizedText("لا يوجد نتائج للبحث"),
                    )
                  : Container(
                      width: 220.w,
                      height: 220.h,
                      margin: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 5.h,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${results[0]['first_name']} ${results[0]['second_name']} ${results[0]['last_name']}',
                            style: GoogleFonts.cairo(
                              color: color1,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
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
                              LocalizedText(
                                ' :  ${results[0]['phone'] == null ? '' : results[0]['phone']}',
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
                              LocalizedText(
                                ' : ${results[0]['idc']}',
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
                                ' : ${results[0]['voter_number']} ',
                                style: GoogleFonts.cairo(
                                  color: black,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          // Row(
                          //   children: [
                          //     LocalizedText(
                          //       'boxid',
                          //       style: GoogleFonts.cairo(
                          //         color: black,
                          //         fontSize: 14.sp,
                          //       ),
                          //     ),
                          //     LocalizedText(
                          //       ' : ${results[0]['box']['box_number']}',
                          //       style: GoogleFonts.cairo(
                          //         color: black,
                          //         fontSize: 14.sp,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // Row(
                          //   children: [
                          //     LocalizedText(
                          //       'boxaddress',
                          //       style: GoogleFonts.cairo(
                          //         color: black,
                          //         fontSize: 14.sp,
                          //       ),
                          //     ),
                          //     LocalizedText(
                          //       ' :  ${results[0]['box']['box_address']}',
                          //       style: GoogleFonts.cairo(
                          //         color: black,
                          //         fontSize: 14.sp,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          Center(
                            child: LocalizedText(
                              '${results[0]['voted'] == 1 ? 'voted' : 'notvoted'}',
                              style: GoogleFonts.cairo(
                                color: results[0]['voted'] == 1 ? Colors.green : Colors.blue,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
