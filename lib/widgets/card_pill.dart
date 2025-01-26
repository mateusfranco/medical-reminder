import 'package:flutter/material.dart';

class CardPill extends StatelessWidget {
  final String title;
  final Function onPressed;

  const CardPill({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text(title),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent, // Cor de fundo transparente
                ),
                onPressed: () => onPressed(),
                label: const Text('Tomar'),
                icon: const Icon(Icons.medication),
              ),],
          ),
        ],
      ),
    );
  }
}
