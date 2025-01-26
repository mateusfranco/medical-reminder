import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:medical_reminder/external/local_notification_framework.dart';

class TratmentProvider extends ChangeNotifier {
  Map<String, MedicalCard> map = {};

  TratmentProvider(Map<String, MedicalCard> mapData) {
    map = mapData;
  }

  List<MedicalCard> get tratments => map.values.toList();

  void add(
    String title,
    int finishTime,
    int hourInterval,
  ) {
    MedicalCard medicalCard = MedicalCard(
      title: title,
      hourInterval: hourInterval,
      finishTime: finishTime,
    );
    map[medicalCard.id] = medicalCard;
    medicalCard.schedule();
    notifyListeners();
  }

  void remove(String title) {
    map.remove(title);
    notifyListeners();
  }
}

class MedicalCard {
  final String id;
  final String title;
  final int hourInterval;
  final int finishTime;
  final int startHour;
  final DateTime startDay;
  var takes = [];
  final NotificationManager notificationManager;

  MedicalCard(
      {required this.title,
      required this.finishTime,
      required this.hourInterval,
      String? id})
      : id = id ?? const Uuid().v4(),
        startDay = DateTime.now(),
        startHour = DateTime.now().hour,
        notificationManager = NotificationManager(name: title);

  Set getHours() {
    var hours = [];
    for (var i = 0; i * hourInterval < finishTime * 24; i++) {
      hours.add((startHour + (i * hourInterval)) % 24);
    }
    return hours.toSet();
  }

  void schedule() {
    final take = [];

    final int numberOfTakePills = ((finishTime * 24) / hourInterval).ceil();
    var current = startDay;
    for (var i = 0; i < numberOfTakePills; i++) {
      notificationManager.scheduleNotification("$title-$current" ,'Lembrete de medicamento', "Hora de tomar o medicamento $title", current);
      take.add(current);
      current = current.add(Duration(hours: hourInterval));
    }
    takes = take;
  }

  void takePill() {
    final now = DateTime.now();

    final diferences = takes.map((takeHour) {
      return now.difference(takeHour);
    }).toList();

    var minDiference = diferences[0];
    for (var diference in diferences) {
      if (minDiference.inSeconds > diference.inSeconds) {
        minDiference = diference;
      }
    }

    final indexOfMinDifference = diferences.indexOf(minDiference);
    final currentTakeHour = takes[indexOfMinDifference];
    takes.removeAt(indexOfMinDifference);
    notificationManager.cancelNotification("$title-$currentTakeHour");
  }

  showTakePill() {
    final now = DateTime.now();

    final diferences = takes.map((takeHour) {
      return now.difference(takeHour);
    }).toList();

    var minDiference = diferences[0];
    for (var diference in diferences) {
      if (minDiference.inSeconds > diference.inSeconds) {
        minDiference = diference;
      }
    }

    final indexOfMinDifference = diferences.indexOf(minDiference);

    return takes[indexOfMinDifference];
  }
}
