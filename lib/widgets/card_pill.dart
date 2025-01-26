import 'package:flutter/material.dart';

class CardPill extends StatelessWidget {
  

  const CardPill({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          const ListTile(
            title: Text('Medicamento'),
            subtitle: Text('Descrição'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent, // Cor de fundo transparente
                ),
                onPressed: () {},
                label: const Text('Tomar'),
                icon: const Icon(Icons.medication),
              ),],
          ),
        ],
      ),
    );
  }
}
