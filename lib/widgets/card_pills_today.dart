import 'package:flutter/material.dart';

class CardPillsToday extends StatelessWidget {
  final int quantity;

  const CardPillsToday({super.key, required this.quantity});

  @override
  Widget build(BuildContext context) {

    String quantityText;
    int fontSize;
    if (quantity != 0) {
      quantityText = quantity.toString();
      fontSize = 80;
    } else {
      quantityText = 'todos os medicamentos em dia';
      fontSize = 20;
    }

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(50),
            child: Text(quantityText ,
                style: TextStyle(
                  fontSize: fontSize.toDouble(),
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(97, 103, 15, 185),
                )),
          ),
        ],
      ),
    );
  }
}
