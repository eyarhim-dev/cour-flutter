import 'package:flutter/material.dart';
import 'package:ma_biblio/models/livre.dart';

class ParametresScreen extends StatelessWidget {
  const ParametresScreen({super.key});

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

    final List<Widget> parametres = [
      ListTile(
        leading: const Icon(Icons.person),
        title: const Text('Mon profil'),
        subtitle: const Text('Nom, e-mail, mot de passe'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Profil sélectionné')));
        },
      ),
      ListTile(
        leading: const Icon(Icons.notifications),
        title: const Text('Notifications'),
        tileColor: Colors.blue.shade50,
        iconColor: Colors.blue,
        textColor: Colors.blue.shade900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      const ListTile(
        leading: Icon(Icons.language),
        title: Text('Langue'),
        subtitle: Text('Français'),
      ),
      const ListTile(
        leading: Icon(Icons.info),
        title: Text('À propos'),
        subtitle: Text('MaBiblio\nInformations sur l’application'),
        isThreeLine: true,
      ),
      ListTile(
        leading: const Icon(Icons.home),
        title: const Text('Accueil'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          ...ListTile.divideTiles(context: context, tiles: parametres),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'Mes livres',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ...livres.take(3).map(livreTile),
        ],
      ),
    );
  }
}
