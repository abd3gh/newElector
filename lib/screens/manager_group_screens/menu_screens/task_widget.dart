import 'package:elector/constants.dart';
import 'package:elector/models/event_data_source.dart';
import 'package:elector/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({Key? key}) : super(key: key);

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final selectedEvent = provider.eventOfSelectedDate;

    if (selectedEvent.isEmpty) {
      return Center(
        child: LocalizedText(
          'لا يوجد أحداث',
          style: GoogleFonts.cairo(
            fontSize: 18.sp,
            color: color1,
          ),
        ),
      );
    }
    return SfCalendar(
      view: CalendarView.timelineDay,
      dataSource: EventDataSource(provider.events),
      initialSelectedDate: provider.selectedDate,
      appointmentBuilder: appointmentBuilder,
      headerHeight: 0,
      todayHighlightColor: black,
      onTap: (details) {
        if (details.appointments == null) return;
        final event = details.appointments!.first;
        // Navigator.of(context).push(
          // MaterialPageRoute(
          //   builder: (context) => EventViewingPage(event: event),
          // ),
        // );
      },
    );
  }

  Widget appointmentBuilder(
    BuildContext context,
    CalendarAppointmentDetails details,
  ) {
    final event = details.appointments.first;
    return Container(
      decoration: BoxDecoration(
        color: color1.withOpacity(0.5),
      ),
      alignment: Alignment.center,
      width: details.bounds.width,
      height: details.bounds.height,
      child: Center(
        child: LocalizedText(
          event.title,
          maxLines: 2,
          style: GoogleFonts.cairo(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
