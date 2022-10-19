import 'package:flutter/material.dart';

class Eventt {
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final Color bg;
  final bool isAllDay;

  const Eventt({
    required this.title,
    required this.description,
    required this.from,
    required this.to,
    this.bg = Colors.black,
    this.isAllDay = false,
  });
}
