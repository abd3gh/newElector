import 'package:elector/constants.dart';
import 'package:elector/models/event_data_source.dart';
import 'package:elector/provider/event_provider.dart';
import 'package:elector/screens/manager_group_screens/menu_screens/event_edditing_page.dart';
import 'package:elector/screens/manager_group_screens/menu_screens/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calender extends StatefulWidget {
  const Calender({Key? key}) : super(key: key);

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: color1,
        ),
        backgroundColor: white,
        title: LocalizedText(
          'التقويم',
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
            color: color1,
          ),
        ),
        centerTitle: true,
      ),
      body: SfCalendar(
        onTap: (details) {
          final provider = Provider.of<EventProvider>(context, listen: false);
          provider.setData(details.date!);
          showModalBottomSheet(
            context: context,
            builder: (context) => TasksWidget(),
          );
        },
        todayHighlightColor: color2,
        cellBorderColor: color1,
        view: CalendarView.month,
        showNavigationArrow: true,
        showWeekNumber: true,
        initialSelectedDate: DateTime.now(),
        dataSource: EventDataSource(events),
        monthViewSettings: MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: white,
        ),
        backgroundColor: color2,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EventEditingPage(),
          ),
        ),
      ),
    );
  }
}

// List<Meeting> _getDataSource() {
//   final List<Meeting> meetings = <Meeting>[];
//   final DateTime today = DateTime.now();
//   final DateTime startTime = DateTime(today.year, today.month, today.day, 9, 0, 0);
//   final DateTime endTime = startTime.add(const Duration(hours: 2));
//   meetings.add(Meeting('Conference', startTime, endTime, color1, false));
//   return meetings;
// }

// class MeetingDataSource extends CalendarDataSource {
//   MeetingDataSource(List<Meeting> source) {
//     appointments = source;
//   }
//
//   @override
//   DateTime getStartTime(int index) {
//     return appointments![index].from;
//   }
//
//   @override
//   DateTime getEndTime(int index) {
//     return appointments![index].to;
//   }
//
//   @override
//   String getSubject(int index) {
//     return appointments![index].eventName;
//   }
//
//   @override
//   Color getColor(int index) {
//     return appointments![index].background;
//   }
//
//   @override
//   bool isAllDay(int index) {
//     return appointments![index].isAllDay;
//   }
// }
//
// class Meeting {
//   Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);
//
//   String eventName;
//   DateTime from;
//   DateTime to;
//   Color background;
//   bool isAllDay;
// }
