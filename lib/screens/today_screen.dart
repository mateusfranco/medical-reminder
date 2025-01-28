import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medical_reminder/providers/tratment_provider.dart';
import 'package:medical_reminder/widgets/card_pill.dart';
import 'package:medical_reminder/widgets/card_pills_today.dart';
import 'package:provider/provider.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tratmentProvider = context.watch<TratmentProvider>();

    int varIndexPill = 0;
    final todayPills = tratmentProvider.map.values
        .expand((pill) => pill.getTodayTakes().map((take) {
              var cardPill = CardPill(
                onPressed: () {
                  pill.takePill();
                },
                title: pill.title,
                day: take,
                disablePress: (varIndexPill == 0) ? false : true,
              );
              varIndexPill++;
              pill.getTodayTakes().length == varIndexPill
                  ? varIndexPill = 0
                  : varIndexPill;
              return cardPill;
            }))
        .toList();

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 80, bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CardPillsToday(quantity: todayPills.length),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 10, right: 10),
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(97, 103, 15, 185), width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(children: todayPills),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
