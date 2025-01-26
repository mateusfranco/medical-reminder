import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medical_reminder/providers/tratment_provider.dart';

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
                    final int duration =
                        int.tryParse(durationController.text) ?? 0;
                    final int interval =
                        int.tryParse(intervalController.text) ?? 0;

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
