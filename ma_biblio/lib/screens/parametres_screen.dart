import 'package:flutter/material.dart';

class ParametresScreen extends StatelessWidget {
  const ParametresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paramètres')),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Mon profil'),
            subtitle: const Text('Nom, e-mail, mot de passe'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profil sélectionné')),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            tileColor: Colors.blue.shade50,
            iconColor: Colors.blue,
            textColor: Colors.blue.shade900,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),

          const ListTile(
            leading: Icon(Icons.language),
            title: Text('Langue'),
            subtitle: Text('Français'),
          ),

          // Q1.4 : tester les propriétés séparément.
          // dense: true réduit la hauteur de la ligne.
          // isThreeLine: true réserve plus de hauteur
          // pour afficher un sous-titre sur deux lignes.
          // enabled: false désactive la ligne et atténue son apparence.
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('À propos'),
            subtitle: const Text('MaBiblio\nInformations sur l’application'),

            // Q1.4 : décommenter une propriété à la fois
            // pour observer son effet.
            // dense: true,
            isThreeLine: true,
            // enabled: false,
          ),
        ],
      ),
    );
  }
}
