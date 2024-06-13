import 'package:alarm_project/alarm_screen.dart';
import 'package:alarm_project/controller.dart';
import 'package:alarm_project/notification.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationHelper().init();
  runApp(AlarmApp());
}

 
class AlarmApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AlarmProvider(),
      child: MaterialApp(
        home: AlarmScreen(),
      ),
    );
  }
}

