import 'package:elector/api/api_controllers/controllers.dart';
import 'package:elector/constants.dart';
import 'package:elector/widgets/app_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';

class AddVoterManually extends StatefulWidget {
  const AddVoterManually({Key? key}) : super(key: key);

  @override
  State<AddVoterManually> createState() => _AddVoterManuallyState();
}

class _AddVoterManuallyState extends State<AddVoterManually> {
  TextEditingController firstName = TextEditingController();
  TextEditingController secondName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController voterNumber = TextEditingController();

  // TextEditingController boxId = TextEditingController();
  List<String> myData = [];
  bool isloading = false;
  String dropdownValue = "";

  getBoxId() async {
    try {
      await ApiControllers().getBoxNumber().then((value) => {
            if (value != null)
              {
                setState(() {
                  // myData = value['data'];
                  value['data'].forEach((element) => myData.add(element['box_number'].toString()));
                }),
                print("the data is $myData")
              }
            else
              {}
          });
    } catch (e) {
      print(e);
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getBoxId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'إضافة ناخب',
          style: GoogleFonts.cairo(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: white,
        iconTheme: IconThemeData(
          color: color1,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: LocalizedText(
                  'firstname',
                  style: GoogleFonts.cairo(
                    color: black,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              AppTextField(
                textEditingController: firstName,
              ),
              SizedBox(
                height: 15.h,
              ),
              Align(
                alignment: Alignment.topRight,
                child: LocalizedText(
                  'secondname',
                  style: GoogleFonts.cairo(
                    color: black,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              AppTextField(
                textEditingController: secondName,
              ),
              SizedBox(
                height: 15.h,
              ),
              Align(
                alignment: Alignment.topRight,
                child: LocalizedText(
                  'lastname',
                  style: GoogleFonts.cairo(
                    color: black,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              AppTextField(
                textEditingController: lastName,
              ),
              SizedBox(
                height: 15.h,
              ),
              Align(
                alignment: Alignment.topRight,
                child: LocalizedText(
                  'phone',
                  style: GoogleFonts.cairo(
                    color: black,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              AppTextField(
                textEditingController: phone,
                textInputType: TextInputType.number,
              ),
              SizedBox(
                height: 15.h,
              ),
              Align(
                alignment: Alignment.topRight,
                child: LocalizedText(
                  'ID',
                  style: GoogleFonts.cairo(
                    color: black,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              AppTextField(
                textEditingController: id,
                textInputType: TextInputType.number,
              ),
              SizedBox(
                height: 15.h,
              ),
              Align(
                alignment: Alignment.topRight,
                child: LocalizedText(
                  'voternumm',
                  style: GoogleFonts.cairo(
                    color: black,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              AppTextField(
                textEditingController: voterNumber,
                textInputType: TextInputType.number,
              ),
              SizedBox(
                height: 15.h,
              ),
              Align(
                alignment: Alignment.topRight,
                child: LocalizedText(
                  'boxid',
                  style: GoogleFonts.cairo(
                    color: black,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // DropdownButton<String>(
              //   items: myData.map((String value) {
              //     return DropdownMenuItem<String>(
              //       value: dropdownValue,
              //       child: Text(
              //         value,
              //         style: GoogleFonts.cairo(
              //             fontSize: 12.sp,
              //             color: Colors.grey.shade600),
              //       ),
              //     );
              //   }).toList(),
              //   isExpanded: true,
              //   underline: const SizedBox(),
              //   // value: dropdownValue,
              //   icon:  Icon(
              //     Icons.arrow_drop_down,
              //     color: color1,
              //   ),
              //   onChanged: (String? newValue) {
              //     setState(() {
              //       dropdownValue = newValue!;
              //     });
              //   },
              // ),
              // AppTextField(
              //   textEditingController: boxId,
              //
              new DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  dropdownValue,
                  style: GoogleFonts.cairo(
                    fontSize: 18.sp,
                    color: black,
                  ),
                ),
                // value: dropdownValue,
                items: myData.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: GoogleFonts.cairo(fontSize: 16.sp, color: Colors.grey.shade600),
                    ),
                  );
                }).toList(),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: color1,
                ),
                onChanged: (val) {
                  setState(() {
                    dropdownValue = val!;
                  });
                },
              ),
              SizedBox(
                height: 15.h,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: color1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    minimumSize: Size(200.w, 50.h),
                  ),
                  onPressed: () async {
                    setState(() {});

                    await ApiControllers().addVoterManually(
                      firstName: firstName.text.trim(),
                      secondName: secondName.text.trim(),
                      lastName: lastName.text.trim(),
                      phone: phone.text.trim(),
                      id: id.text.trim(),
                      voterNumber: voterNumber.text.trim(),
                      boxId: dropdownValue,
                    );
                    
                    setState(() {});
                  },
                  child: LocalizedText(
                    'send',
                    style: GoogleFonts.cairo(
                      color: white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
