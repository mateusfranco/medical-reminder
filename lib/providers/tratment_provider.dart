import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:medical_reminder/external/local_notification_framework.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    map[title]?.removeTratment();
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
  final List<DateTime> takes = [];
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
    final int numberOfTakePills = ((finishTime * 24) / hourInterval).ceil();
    var current = startDay;
    for (var i = 0; i < numberOfTakePills; i++) {
      if (i != 0) {
        notificationManager.scheduleNotification(
            "$title-$current",
            'Lembrete de medicamento',
            "Hora de tomar o medicamento $title",
            current);
        takes.add(current);
        current = current.add(Duration(hours: hourInterval));
      } else {
        current = current.add(Duration(hours: hourInterval));
      }
    }
  }

  void takePill() {
    try {
      final now = DateTime.now();

      final diferences = takes.map((takeHour) {
        return now.difference(takeHour);
      }).toList();

      var minDiference = diferences[0];
      for (var diference in diferences) {
        if (minDiference.inSeconds < diference.inSeconds) {
          minDiference = diference;
        }
      }

      if (minDiference.inSeconds.abs() > 3600) {
        throw Exception("Não é hora de tomar o medicamento");
      }

      final indexOfMinDifference = diferences.indexOf(minDiference);
      final currentTakeHour = takes[indexOfMinDifference];
      takes.removeAt(indexOfMinDifference);
      notificationManager.cancelNotification("$title-$currentTakeHour");
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString().split(':')[1],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  DateTime showTakePill() {
    final now = DateTime.now();

    final diferences = takes.map((takeHour) {
      return now.difference(takeHour);
    }).toList();

    var minDiference = diferences[0];
    for (var diference in diferences) {
      if (minDiference.inSeconds < diference.inSeconds) {
        minDiference = diference;
      }
    }

    final indexOfMinDifference = diferences.indexOf(minDiference);

    return takes[indexOfMinDifference];
  }

  List<DateTime> getTodayTakes() {
    final now = DateTime.now();
    final List<DateTime> todayTratments = [];

    for (var take in takes) {
      if (take.day == now.day &&
          take.month == now.month &&
          take.year == now.year) {
        todayTratments.add(take);
      }
    }

    return todayTratments;
  }

  void removeTratment() {
    for (var take in takes) {
      notificationManager.cancelNotification("$title-$take");
    }
  }
}
