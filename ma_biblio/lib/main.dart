import 'package:flutter/material.dart';
import 'package:ma_biblio/models/livre.dart';
import 'package:ma_biblio/screens/parametres_screen.dart';

void main() {
  runApp(const MaBiblioApp());
}

class MaBiblioApp extends StatelessWidget {
  const MaBiblioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaBiblio',
      theme: ThemeData(useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Trois livres temporaires pour vérifier l'affichage.
  final List<Livre> livres = [
    Livre(
      id: 1,
      titre: 'Le Petit Prince',
      auteur: 'Antoine de Saint-Exupéry',
      genre: 'Roman',
      annee: 1943,
      note: 4.8,
      couleur: Colors.orange,
    ),
    Livre(
      id: 2,
      titre: 'Une brève histoire du temps',
      auteur: 'Stephen Hawking',
      genre: 'Science',
      annee: 1988,
      note: 4.7,
      couleur: Colors.blue,
    ),
    Livre(
      id: 3,
      titre: 'Les Misérables',
      auteur: 'Victor Hugo',
      genre: 'Roman',
      annee: 1862,
      note: 4.9,
      couleur: Colors.green,
    ),
  ];

  // Q1.7 : afficher un livre sous forme de ListTile.
  Widget livreTile(Livre livre) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: livre.couleur,
        child: Text(
          livre.titre.isNotEmpty ? livre.titre[0] : '?',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(livre.titre),
      subtitle: Text('${livre.auteur} – ${livre.annee}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(livre.note.toString()),
          const SizedBox(width: 4),
          const Icon(Icons.star, color: Colors.yellow),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MaBiblio'),
        actions: [
          // Q1.6 : ouvrir l'écran Paramètres.
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Paramètres',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ParametresScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(children: livres.take(3).map(livreTile).toList()),
    );
  }
}
