import 'package:flutter/widgets.dart';
import 'package:medical_reminder/widgets/card_pill.dart';
import 'package:medical_reminder/widgets/card_pills_today.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CardPillsToday(),
          SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(children: [
                    CardPill(
                      onPressed: () {},
                      title: 'teste medicamento',
                    ),
                  ])))
        ],
      ),
    );
  }
}
