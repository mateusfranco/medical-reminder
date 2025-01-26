import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final Function onPressed;

  const AddButton({
    Key? key,
    required this.onPressed,
    Color? color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 50),
          backgroundColor: Colors.white, 
          shadowColor: const Color.fromARGB(97, 103, 15, 185),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
        label: Text('adicionar medicamento'),
        icon: Icon(Icons.add),
        onPressed: () => this.onPressed(),
      ),
    );
  }
}
