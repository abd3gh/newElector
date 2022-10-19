import 'dart:developer';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as excel;

import 'package:elector/api/api_controllers/controllers.dart';
import 'package:elector/constants.dart';
import 'package:elector/screens/box_man_screen/AddElectors/sqlElectors.dart';
import 'package:elector/widgets/app_text_feild.dart';
import 'package:elector/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';

import '../../../api/api_controllers/pref_manager.dart';
import '../../manager_group_screens/auth/login_screen.dart';

class AddElector extends StatefulWidget {
  const AddElector({Key? key, this.remove = false}) : super(key: key);
  final bool remove;
  @override
  State<AddElector> createState() => _AddElectorState();
}

class _AddElectorState extends State<AddElector> {
  late TextEditingController _electorController;
  late TextEditingController editController;
  List<Map<String, dynamic>> electors = [];
  List numELectors = [];
  void refreshElector() async {
    final data = await SQLElectors.getItems();
    setState(() {
      electors = data;
    });
  }

  createExcel()async{
    numELectors = [];
    for(int i = 0 ; i < electors.length ; i++){
      numELectors.add(electors[i]['num']);
      log(numELectors[i].toString());
    }
    excel.Workbook workbook = excel.Workbook();
    excel.Worksheet sheet = workbook.worksheets[0];
    sheet.getRangeByName('A1').setText('رقم الناخب');
    // excel.Range range = sheet.getRangeByName('A1');
    // range.setText('رقم الناخب11');
    // sheet.insertColumn(3, 2, excel.ExcelInsertOptions.formatAsBefore);
    sheet.importList(numELectors, 2, 1, true);
    sheet.autoFitColumn(1);
    // sheet.getRangeByName('A2').setText("Hellp !");
    List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    String path = (await getApplicationSupportDirectory()).path;
    String fileName = '$path/output.xlsx';
    File file = File(fileName);
    await file.writeAsBytes(bytes,flush: true);
    OpenFile.open(fileName);



  }




  @override
  void initState() {
    _electorController = TextEditingController();
    editController = TextEditingController();
    refreshElector();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _electorController.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _electorController.text = "";
    editController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LocalizedText(
          'votersss',
          style: GoogleFonts.cairo(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: color1,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await PrefManager().remove('userdetails');
              Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()))
                  .then((value) => {exit(0)});
            },
            icon: Icon(
              Icons.logout,
              color: color1,
            ),
          ),
        ],
        backgroundColor: white,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
               SizedBox(
                height: 30.h,
              ),
              LocalizedText(
                'num',
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
                textEditingController: _electorController,
                textInputType: TextInputType.number,
              ),
              SizedBox(
                height: 15.h,
              ),
              WidgetButton(
                onPress: () async {
                  ApiControllers().addelector(
                      voters_id: _electorController.text.trim(),
                      remove: widget.remove);
                  // _electorController.clear();

                  setState(() {
                    SQLElectors.createItem(_electorController.text);
                    refreshElector();
                    _electorController.clear();
                  });

                },
                text: (widget.remove) ? "الغاء تشطيب" : 'تشطيب',
                buttonColor: color1,
              ),
              SizedBox(height: 10.h,),

              WidgetButton(
                onPress: () async {
                  // ApiControllers().addelector(
                  //     voters_id: _electorController.text.trim(),
                  //     remove: widget.remove);
                  // _electorController.clear();
                  createExcel();

                },
                text: 'تحميل',
                buttonColor: color1,
              ),

              SizedBox(height: 10.h,),


              electors.length==0 ?
                  Text('لا يوجد ناخبين'):
              SizedBox(
                height: 250.h,
                child: ListView.builder(
                  itemCount: electors.length,
                    itemBuilder: (context, index) {
                      return Container(child:

                      Row(
                        children: [
                          Text(electors[index]['num']),
                          Spacer(),
                          IconButton(onPressed: (){
                            setState(() {
                              SQLElectors.deleteItem(electors[index]['id']);
                              refreshElector();

                            });


                          },
                              icon: Icon(Icons.delete,color: color1,)),

                          IconButton(
                              onPressed: (){
                            showDialog(
                                context: context,
                                builder: (context){
                                  return AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('ادخل الرقم الجديد'),
                                        AppTextField(
                                          textEditingController: editController,
                                          textInputType: TextInputType.number,
                                        ),
                                        SizedBox(height: 15.h,),
                                        WidgetButton(
                                          onPress: ()  {
                                            setState(() {
                                              SQLElectors.updateItem(electors[index]['id'], editController.text);
                                              refreshElector();
                                              editController.clear();
                                            });
                                            Navigator.pop(context);

                                          },
                                          text: 'تعديل',
                                          buttonColor: color1,
                                        ),



                                        // FlatButton(
                                        //   color: Colors.red,
                                        //   textColor: Colors.white,
                                        //   child: Text("تعديل",style: TextStyle(fontSize: 15.sp),),
                                        //   onPressed: () {
                                        //     setState(() {
                                        //       SQLElectors.updateItem(electors[index]['id'], editController.text);
                                        //       refreshElector();
                                        //       editController.clear();
                                        //     });
                                        //     Navigator.pop(context);
                                        //   },
                                        // ),
                                      ],
                                    ),
                                  );
                                });
                          }, icon: Icon(Icons.edit)),

                        ],
                      ));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
