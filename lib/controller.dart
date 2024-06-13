import 'package:alarm_project/database.dart';
import 'package:alarm_project/model.dart';
import 'package:flutter/material.dart';

class AlarmProvider with ChangeNotifier {
  List<Alarm> _alarms = [];

  List<Alarm> get alarms => _alarms;

  Future<void> loadAlarms() async {
    _alarms = await DatabaseHelper().getAlarms();
    notifyListeners();
  }

  Future<void> addAlarm(Alarm alarm) async {
    await DatabaseHelper().insertAlarm(alarm);
    await loadAlarms();
  }

  Future<void> updateAlarm(Alarm alarm) async {
    await DatabaseHelper().updateAlarm(alarm);
    await loadAlarms();
  }

  Future<void> deleteAlarm(int id) async {
    await DatabaseHelper().deleteAlarm(id);
    await loadAlarms();
  }
}
