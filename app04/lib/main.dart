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
      home: const SumPage(),
    );
  }
}

class SumPage extends StatefulWidget {
  const SumPage({super.key});

  @override
  State<SumPage> createState() => _SumPageState();
}

class _SumPageState extends State<SumPage> {
  final TextEditingController _textController1 = TextEditingController();

  final TextEditingController _textController2 = TextEditingController();

  String _result = '';

  void _handleSubmitted() {
    final int value1 = int.tryParse(_textController1.text) ?? 0;

    final int value2 = int.tryParse(_textController2.text) ?? 0;

    final int sum = value1 + value2;

    setState(() {
      _result = 'La somme de $value1 et $value2 est $sum';

      _textController1.clear();
      _textController2.clear();
    });
  }

  @override
  void dispose() {
    _textController1.dispose();
    _textController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calcul de la somme'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _textController1,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Entrez le premier nombre',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _textController2,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Entrez le deuxième nombre',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleSubmitted,
                child: const Text('Valider'),
              ),
              const SizedBox(height: 20),
              Text(
                _result,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
