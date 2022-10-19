//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_contacts/flutter_contacts.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class EventViewingPage extends StatefulWidget {
//   final Event event;
//   const EventViewingPage({Key? key, required this.event}) : super(key: key);
//
//   @override
//   State<EventViewingPage> createState() => _EventViewingPageState();
// }
//
// class _EventViewingPageState extends State<EventViewingPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: CloseButton(),
//         actions: buildViewActions(context, event),
//
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(20.w),
//         children: <Widget>[
//           buidDateTime(event),
//           SizedBox(height: 30.h,),
//           Text(event.title),
//           SizedBox(height: 15.h,),
//           Text(event.description),
//         ],
//       ),
//     );
//
//   }
//   Widget buidDateTime(Event event){
//     return Column(
//       children: [
//
//       ],
//     );
//   }
// }
