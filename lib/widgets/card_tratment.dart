import 'package:flutter/material.dart';
import 'package:medical_reminder/providers/tratment_provider.dart';
import 'package:provider/provider.dart';

class CardTratment extends StatelessWidget {
  final dynamic remaining;
  final dynamic title;
  final String id;

  const CardTratment({
    super.key,
    this.title,
    this.remaining,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final tratmentProvider = context.watch<TratmentProvider>();

    return Card(
      margin: const EdgeInsets.all(20),
      color: Colors.yellow[200],
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                    onPressed: () {
                      tratmentProvider.remove(id);
                    },
                    icon: const Icon(Icons.remove_circle),
                    label: const Text('Remover')),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tempo restante do tratamento: $remaining dias'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
