import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Exemple 01 : TextEditingController
  final TextEditingController _controller = TextEditingController();

  String _resultatController = '';

  void _recupererValeur() {
    setState(() {
      _resultatController = _controller.text;
    });
  }

  // Exemple 02 : onChanged
  String _valeurOnChanged = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Récupérer la valeur d’un TextField'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // EXEMPLE 01
            const Text(
              'Exemple 01 : TextEditingController',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Saisissez un texte',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: _recupererValeur,
              child: const Text('Récupérer la valeur'),
            ),
            const SizedBox(height: 12),

            Text(
              'Valeur saisie : $_resultatController',
              style: const TextStyle(fontSize: 18, color: Colors.green),
            ),

            const Divider(height: 40),

            // EXEMPLE 02
            const Text(
              'Exemple 02 : onChanged',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            TextField(
              decoration: const InputDecoration(
                labelText: 'Saisissez un autre texte',
                border: OutlineInputBorder(),
              ),
              onChanged: (String value) {
                setState(() {
                  _valeurOnChanged = value;
                });
              },
            ),
            const SizedBox(height: 12),

            Text(
              'Valeur saisie : $_valeurOnChanged',
              style: const TextStyle(fontSize: 18, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
