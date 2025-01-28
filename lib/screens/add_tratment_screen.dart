import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medical_reminder/providers/tratment_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddTratmentScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController intervalController = TextEditingController();

  AddTratmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tratmentProvider = context.watch<TratmentProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Tratamento'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome do tratamento',
                ),
              ),
              TextField(
                controller: durationController,
                decoration: const InputDecoration(
                  labelText: 'Duração do tratamento em dias',
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: intervalController,
                decoration: const InputDecoration(
                  labelText: 'Intervalo em horas',
                ),
                keyboardType: TextInputType.number,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  onPressed: () {
                    final String name = nameController.text;
                    final int? duration = int.tryParse(durationController.text);
                    final int? interval = int.tryParse(intervalController.text);

                    if (duration == null || duration <= 0) {
                      Fluttertoast.showToast(
                        msg: "A duração deve ser um número inteiro positivo maior que 0.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      return;
                    }

                    if (interval == null || interval <= 0) {
                      Fluttertoast.showToast(
                        msg: "O intervalo deve ser um número inteiro positivo maior que 0.",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      return;
                    }

                    tratmentProvider.add(name, duration, interval);
                    
                    Navigator.of(context).pop();
                  },
                  child: const Text('Adicionar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}