import 'package:flutter/material.dart';
import 'package:medical_reminder/external/local_notification_framework.dart';
import 'package:medical_reminder/providers/tratment_provider.dart';
import 'package:medical_reminder/widgets/add_button.dart';
import 'package:medical_reminder/widgets/card_tratment.dart';
import 'package:provider/provider.dart';

class TratmentScreen extends StatelessWidget {
  const TratmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tratmentProvider = context.watch<TratmentProvider>();

    showPendingNotifications();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tratamentos'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          AddButton(
              key: key,
              onPressed: () {
                Navigator.pushNamed(context, '/add_tratment');
              }),
          for (var tratment in tratmentProvider.tratments)
            CardTratment(
              key: Key(tratment.id.toString()),
              id: tratment.id,
              remaining: tratment.finishTime -
                  tratment.startDay.difference(DateTime.now()).inDays,
              title: tratment.title,
            ),
        ],
      )),
    );
  }
}
