import 'package:flutter/material.dart';
import 'package:ma_biblio/models/livre.dart';

class CatalogueScreen extends StatelessWidget {
  const CatalogueScreen({super.key});

  Widget livreTile(Livre livre) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: livre.couleur,
        child: Text(
          livre.titre.isNotEmpty ? livre.titre[0].toUpperCase() : '?',
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
    final List<Livre> livres = [
      Livre(
        id: 1,
        titre: 'Le Petit Prince',
        auteur: 'Antoine de Saint-Exupéry',
        genre: 'Roman',
        annee: 1943,
        note: 4.8,
        couleur: Colors.orange,
        nouveaute: true,
      ),
      Livre(
        id: 2,
        titre: 'Une brève histoire du temps',
        auteur: 'Stephen Hawking',
        genre: 'Science',
        annee: 1988,
        note: 4.7,
        couleur: Colors.blue,
        nouveaute: false,
      ),
      Livre(
        id: 3,
        titre: 'Les Misérables',
        auteur: 'Victor Hugo',
        genre: 'Roman',
        annee: 1862,
        note: 4.9,
        couleur: Colors.green,
        nouveaute: true,
      ),
    ];

    // Q2.5 : builder construit progressivement les éléments visibles.
    // C'est plus adapté à une liste de 1000 livres qu'une liste
    // créée entièrement avec ListView(children: ...).

    final nouveautes = livres.where((livre) => livre.nouveaute).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Catalogue')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'Nouveautés',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 160,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(8),
              children: nouveautes.map((livre) {
                return Container(
                  width: 110,
                  margin: const EdgeInsets.only(right: 8),
                  color: livre.couleur,
                  alignment: Alignment.center,
                  child: Text(
                    livre.titre,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'Tout le catalogue',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: livres.length,
              itemBuilder: (context, index) {
                return livreTile(livres[index]);
              },
              separatorBuilder: (context, index) {
                return const Divider(indent: 72);
              },
            ),
          ),
        ],
      ),
    );
  }
}
