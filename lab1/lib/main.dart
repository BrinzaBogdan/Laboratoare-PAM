// Laborator 1 - Varianta 3: Calculator consum combustibil
// Autor: Brînză Bogdan
import 'package:flutter/material.dart';

void main() => runApp(const FuelApp());

class FuelApp extends StatelessWidget {
  const FuelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator consum combustibil',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: const FuelPage(),
    );
  }
}

class FuelPage extends StatefulWidget {
  const FuelPage({super.key});

  @override
  State<FuelPage> createState() => _FuelPageState();
}

class _FuelPageState extends State<FuelPage> {
  final _distanceController = TextEditingController();
  final _fuelController = TextEditingController();
  String _output = 'Introduceți datele și apăsați "Calculează".';

  void _calculate() {
    final distance =
        double.tryParse(_distanceController.text.replaceAll(',', '.'));
    final fuel = double.tryParse(_fuelController.text.replaceAll(',', '.'));

    if (distance == null || distance <= 0 || fuel == null || fuel < 0) {
      setState(() => _output =
          'Introduceți o distanță pozitivă și o cantitate de combustibil validă.');
      return;
    }

    final consumption = fuel / distance * 100;
    setState(() =>
        _output = 'Consum mediu: ${consumption.toStringAsFixed(2)} l/100 km');
  }

  @override
  void dispose() {
    _distanceController.dispose();
    _fuelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Consum combustibil')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _distanceController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Distanța parcursă (km)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _fuelController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Combustibil consumat (litri)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calculate,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Calculează'),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              _output,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
