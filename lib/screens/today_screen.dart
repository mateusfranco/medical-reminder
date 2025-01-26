import 'package:flutter/widgets.dart';
import 'package:medical_reminder/widgets/card_pill.dart';
import 'package:medical_reminder/widgets/card_pills_today.dart';

class TodayScreen extends StatelessWidget{
  const TodayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CardPillsToday(),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  CardPill(),
                ]
              )
            )
          )
        ],
      ),
    );
  }
}