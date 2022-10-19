import 'dart:convert';

import 'package:elector/api/api_controllers/pref_manager.dart';
import 'package:elector/models/event.dart';
import 'package:flutter/foundation.dart';

class EventProvider extends ChangeNotifier {
  final List<Eventt> _events = [];
  final List<String> saved = [];
  final List<String> savedFollower = [];
  final List<String> savedWith = [];

  List<Eventt> get events => _events;


  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;


  void setData(DateTime date) => _selectedDate = date;

  List<Eventt> get eventOfSelectedDate =>_events;


  void addEvent(Eventt eventt) {
    _events.add(eventt);
    notifyListeners();
  }
  void addSaveToList(id){
    saved.add(id);
    PrefManager().saveData(encode(saved));
    notifyListeners();
  }

  getSavedData() async {
    saved.clear();
    String s = await PrefManager().getData();
    if(s.isNotEmpty)
      saved.addAll(decode(s));
    notifyListeners();
  }

  void addSaveWithToList(id){
    savedWith.add(id);
    PrefManager().saveWithData(encode(savedWith));
    notifyListeners();
  }

  getSavedWithData() async {
    savedWith.clear();
   String s = await PrefManager().getWithData();
    if(s.isNotEmpty)
      savedWith.addAll(decode(s));
    notifyListeners();
  }
  deleteSavedData(id) async {
    saved.removeWhere((element) => element == id);
    notifyListeners();
  }

  deleteSavedWithData(id) async {
    savedWith.removeWhere((element) => element == id);
    notifyListeners();
  }
// اضافة كتابع
  void addSaveFollowerToList(id){
    savedFollower.add(id);
    PrefManager().saveFollowerData(encode(savedFollower));
    notifyListeners();
  }

  getSavedFollowerData() async {
    savedFollower.clear();
    String s = await PrefManager().getSavedFollowerData();
    if(s.isNotEmpty)
      savedFollower.addAll(decode(s));
    notifyListeners();
  }
  deleteSavedFollowerData(id) async {
    savedFollower.removeWhere((element) => element == id);
    notifyListeners();
  }
  // static List<String> decode(String moscues) => json.decode(moscues);

  static List<String> decode(String moscues) =>
      (json.decode(moscues) as List<dynamic>)
          .map<String>((item) => item)
          .toList();

  static String encode(List<String> moscues) => json.encode(moscues);
}
