import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardPill extends StatelessWidget {
  final String title;
  final DateTime day;
  final Function onPressed;
  final bool disablePress;

  const CardPill({
    super.key,
    required this.title,
    required this.day,
    required this.onPressed,
    this.disablePress = false,
  });

  String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd/MM HH:mm');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text(title,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ),
          Padding(padding: const EdgeInsets.only(bottom: 16),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(formatDateTime(day),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold))),
                if(!disablePress) TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor:
                        Colors.transparent, // Cor de fundo transparente
                  ),
                  onPressed: () => onPressed(),
                  label: const Text('Tomar'),
                  icon: const Icon(Icons.medication),
                ),
                
              ],
            ),
          )
          
        ],
      ),
    );
  }
}
