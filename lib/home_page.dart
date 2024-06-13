import 'package:alarm_project/controller.dart';
import 'package:alarm_project/service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class AlarmScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AlarmProvider(),
      child: MaterialApp(
        home: AlarmList(),
      ),
    );
  }
}

class AlarmList extends StatefulWidget {
  @override
  _AlarmListState createState() => _AlarmListState();
}

class _AlarmListState extends State<AlarmList> {
  String? _weather;

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    WeatherService weatherService = WeatherService();
    String weather = await weatherService.fetchWeather(
        position.latitude, position.longitude);
    setState(() {
      _weather = weather;
    });
  }

  @override
  Widget build(BuildContext context) {
    final alarmProvider = Provider.of<AlarmProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarm App'),
      ),
      body: Column(
        children: [
          if (_weather != null)
            Container(
              padding: EdgeInsets.all(16),
              child: Text('Current Weather: $_weather'),
            ),
          Expanded(
            child: FutureBuilder(
              future: alarmProvider.loadAlarms(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: alarmProvider.alarms.length,
                    itemBuilder: (context, index) {
                      final alarm = alarmProvider.alarms[index];
                      return ListTile(
                        title: Text(alarm.label),
                        subtitle: Text(alarm.time.toLocal().toString()),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            alarmProvider.deleteAlarm(alarm.id);
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Code to add a new alarm
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
