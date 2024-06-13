class Alarm {
  int id;
  String label;
  DateTime time;

  Alarm({required this.id, required this.label, required this.time});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'label': label,
      'time': time.toIso8601String(),
    };
  }

  factory Alarm.fromMap(Map<String, dynamic> map) {
    return Alarm(
      id: map['id'],
      label: map['label'],
      time: DateTime.parse(map['time']),
    );
  }
}
