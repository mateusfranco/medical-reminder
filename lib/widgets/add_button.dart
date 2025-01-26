import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final Function onPressed;

  const AddButton({
    super.key,
    required this.onPressed,
    Color? color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: Colors.white, 
          shadowColor: const Color.fromARGB(97, 103, 15, 185),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
        label: const Text('adicionar medicamento'),
        icon: const Icon(Icons.add),
        onPressed: () => onPressed(),
      ),
    );
  }
}
