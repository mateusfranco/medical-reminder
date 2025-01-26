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
      margin: EdgeInsets.all(20),
      color: Colors.yellow[200],
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ],
            ),
            Row(
              children: [
                Text('Hora de tomar o medicamento: '),
                Text(time.toString() + ' horas'),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Text('Tempo restante do tratamento: '),
                  Text(remaining.toString() + ' dias'),
                ],
              ),
            )
          ],
        ),
      ),
    );
    
  }
  
}