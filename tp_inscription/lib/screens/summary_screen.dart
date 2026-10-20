import 'package:flutter/material.dart';

import '../models/user_profile.dart';

class SummaryScreen extends StatefulWidget {
  final UserProfile profile;
  final VoidCallback onBack;
  final VoidCallback onReset;

  const SummaryScreen({
    super.key,
    required this.profile,
    required this.onBack,
    required this.onReset,
  });

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final _formKey = GlobalKey<FormState>();

  void _confirmRegistration() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.check_circle_outline,
            color: Colors.green,
            size: 52,
          ),
          title: const Text('Inscription réussie !'),
          content: const Text('Votre compte a été créé avec succès.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                widget.onReset();
              },
              child: const Text('Terminer'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _resetWithConfirmation() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Réinitialiser l’inscription ?'),
          content: const Text(
            'Toutes les informations saisies seront réinitialisées.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
              child: const Text('Réinitialiser'),
            ),
          ],
        );
      },
    );

    if (confirmed == true && mounted) {
      widget.onReset();
    }
  }

  Widget _infoCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _infoLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 3),
          Text(
            value.isEmpty ? 'Non renseigné' : value,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profile = widget.profile;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Récapitulatif de votre profil'),
        centerTitle: true,
        leading: IconButton(
          onPressed: widget.onBack,
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Retour',
        ),
        actions: [
          IconButton(
            onPressed: _resetWithConfirmation,
            icon: const Icon(Icons.refresh),
            tooltip: 'Réinitialiser',
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4),
          child: LinearProgressIndicator(value: 1.0),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Récapitulatif',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Vérifiez vos informations avant de confirmer.',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),

                _infoCard(
                  title: 'Informations personnelles',
                  icon: Icons.person_outline,
                  children: [
                    _infoLine('Nom complet', profile.nomComplet),
                    _infoLine('E-mail', profile.email),
                  ],
                ),

                _infoCard(
                  title: 'Profil professionnel',
                  icon: Icons.work_outline,
                  children: [
                    _infoLine('Profession', profile.profession),
                    _infoLine(
                      'Années d’expérience',
                      '${profile.experience} an(s)',
                    ),
                    _infoLine('TJM', '${profile.tjm.toStringAsFixed(2)} €'),
                    _infoLine('Biographie', profile.biographie),
                  ],
                ),

                FormField<bool>(
                  initialValue: false,
                  validator: (value) {
                    if (value != true) {
                      return 'Veuillez accepter les conditions.';
                    }
                    return null;
                  },
                  builder: (field) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CheckboxListTile(
                          value: field.value ?? false,
                          onChanged: (value) {
                            field.didChange(value ?? false);
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          title: const Text(
                            'J’accepte les conditions d’utilisation.',
                          ),
                        ),
                        if (field.hasError)
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              field.errorText!,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: _confirmRegistration,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Confirmer l’inscription'),
                ),

                const SizedBox(height: 12),

                OutlinedButton(
                  onPressed: widget.onBack,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Retour'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
