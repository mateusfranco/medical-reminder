import 'package:flutter/material.dart';

class CardTratment extends StatelessWidget{
  final dynamic remaining;
  final dynamic title;
  final dynamic time;

  const CardTratment({
    super.key,
    this.title,
    this.time,
    this.remaining,
  });

  
  @override
  Widget build(BuildContext context) {
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
                Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                TextButton.icon(onPressed: () {}, icon: const Icon(Icons.remove_circle), label: const Text('Remover')),
              ],
            ),
            Row(
              children: [
                const Text('Hora de tomar o medicamento: '),
                Text('$time horas'),
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