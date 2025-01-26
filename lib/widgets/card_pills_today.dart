import 'package:flutter/material.dart';

class CardPillsToday extends StatelessWidget {
  const CardPillsToday({super.key});

  @override
  Widget build(BuildContext context) {
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
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.only(bottom: 50), child: 
            Text('0', style: TextStyle(fontSize: 80, fontWeight: FontWeight.w400, color: Color.fromARGB(97, 103, 15, 185),)),
          ),
          Text('/', style: TextStyle(fontSize: 70)),
          Padding(padding: EdgeInsets.only(top: 50), child: 
            Text('2', style: TextStyle(fontSize: 80, fontWeight: FontWeight.w400, color: Color.fromARGB(97, 103, 15, 185),)),
          ),
        ],
      ),
      
    );  
  }

}