import 'package:elector/constants.dart';
import 'package:elector/models/event.dart';
import 'package:elector/provider/event_provider.dart';
import 'package:elector/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:provider/provider.dart';

class EventEditingPage extends StatefulWidget {
  final Event? event;

  const EventEditingPage({Key? key, this.event}) : super(key: key);

  @override
  State<EventEditingPage> createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  late DateTime fromDate;
  late DateTime toDate;

  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(
        const Duration(hours: 2),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: color1,
        ),
        backgroundColor: white,
        title: LocalizedText(
          'الأحداث',
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
            color: color1,
          ),
        ),
        leading: CloseButton(),
        actions: buildEditigAction(),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildTitle(),
              SizedBox(
                height: 12.h,
              ),
              buildDateTimePicker(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTitle() => TextFormField(
        controller: titleController,
        style: GoogleFonts.cairo(
          fontSize: 20.sp,
        ),
        onFieldSubmitted: (_) => saveForm(),
        validator: (title) => title != null && title.isEmpty ? 'لا يمكن أن يكون العنوان فارغاً' : null,
        decoration: InputDecoration(
          hintText: 'العنوان',
          hintStyle: GoogleFonts.cairo(
            fontSize: 15.sp,
            color: Colors.grey,
          ),
        ),
      );

  Widget buildDateTimePicker() => Column(
        children: [
          buildForm(),
          buildTo(),
        ],
      );

  Widget buildForm() => buildHeader(
        header: 'من',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropDownFeild(
                text: Utils.toDate(fromDate),
                onClicked: () => PickFromDateTime(pickDate: true),
              ),
            ),
            Expanded(
              child: buildDropDownFeild(
                text: Utils.toTime(fromDate),
                onClicked: () => PickFromDateTime(pickDate: false),
              ),
            ),
          ],
        ),
      );

  Widget buildTo() => buildHeader(
        header: 'إلى',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropDownFeild(
                text: Utils.toDate(toDate),
                onClicked: () => PickToDateTime(pickDate: true),
              ),
            ),
            Expanded(
              child: buildDropDownFeild(
                text: Utils.toTime(toDate),
                onClicked: () => PickToDateTime(pickDate: false),
              ),
            ),
          ],
        ),
      );

  Future PickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if (date == null) return;
    if (date.isAfter(toDate)) {
      toDate = DateTime(
        date.year,
        date.month,
        date.day,
        toDate.hour,
        toDate.minute,
      );
    }
    setState(() => fromDate = date);
  }

  Future PickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(
      toDate,
      pickDate: pickDate,
      firstDate: pickDate ? fromDate : null,
    );
    if (date == null) return;
    // if (date.isAfter(toDate)) {
    //   toDate = DateTime(
    //     date.year,
    //     date.month,
    //     date.day,
    //     toDate.hour,
    //     toDate.minute,
    //   );
    // }
    setState(() => toDate = date);
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2015, 8),
        lastDate: DateTime(2122),
      );

      if (date == null) return null;

      final time = Duration(
        hours: initialDate.hour,
        minutes: initialDate.minute,
      );
      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );
      if (timeOfDay == null) return null;
      final date = DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }

  Widget buildHeader({
    required String header,
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LocalizedText(
            header,
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.bold,
              color: color2,
            ),
          ),
          child,
        ],
      );

  Widget buildDropDownFeild({
    required String text,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        title: LocalizedText(text),
        onTap: onClicked,
        trailing: Icon(Icons.arrow_drop_down),
      );

  List<Widget> buildEditigAction() => [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: white,
            elevation: 0.0,
            shadowColor: Colors.transparent,
          ),
          onPressed: saveForm,
          icon: Icon(
            Icons.done,
            color: color1,
          ),
          label: LocalizedText(
            'حفظ',
            style: GoogleFonts.cairo(
              color: color1,
            ),
          ),
        ),
      ];

  Future saveForm() async {
    final isVailed = _formKey.currentState!.validate();
    if (isVailed) {
      final event = Eventt(
        title: titleController.text,
        description: 'الوصف',
        from: fromDate,
        to: toDate,
        isAllDay: false,
      );
      final provider = Provider.of<EventProvider>(context, listen: false);
      provider.addEvent(event);
      Navigator.of(context).pop();
    }
  }
}
