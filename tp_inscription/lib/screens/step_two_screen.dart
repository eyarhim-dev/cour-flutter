import 'package:flutter/material.dart';

import '../models/user_profile.dart';
import '../utils/validators.dart';

class StepTwoScreen extends StatefulWidget {
  final UserProfile initialProfile;
  final ValueChanged<UserProfile> onNext;
  final VoidCallback onBack;

  const StepTwoScreen({
    super.key,
    required this.initialProfile,
    required this.onNext,
    required this.onBack,
  });

  @override
  State<StepTwoScreen> createState() => _StepTwoScreenState();
}

class _StepTwoScreenState extends State<StepTwoScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _professionController;
  late final TextEditingController _experienceController;
  late final TextEditingController _tjmController;
  late final TextEditingController _biographieController;

  @override
  void initState() {
    super.initState();

    _professionController = TextEditingController(
      text: widget.initialProfile.profession,
    );
    _experienceController = TextEditingController(
      text: widget.initialProfile.experience == 0
          ? ''
          : widget.initialProfile.experience.toString(),
    );
    _tjmController = TextEditingController(
      text: widget.initialProfile.tjm == 0
          ? ''
          : widget.initialProfile.tjm.toString(),
    );
    _biographieController = TextEditingController(
      text: widget.initialProfile.biographie,
    );
  }

  @override
  void dispose() {
    _professionController.dispose();
    _experienceController.dispose();
    _tjmController.dispose();
    _biographieController.dispose();
    super.dispose();
  }

  void _goToNextStep() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final profile = widget.initialProfile.copyWith(
      profession: _professionController.text.trim(),
      experience: int.parse(_experienceController.text.trim()),
      tjm: double.parse(_tjmController.text.trim().replaceAll(',', '.')),
      biographie: _biographieController.text.trim(),
    );

    widget.onNext(profile);
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription - Étape 2/3'),
        centerTitle: true,
        leading: IconButton(
          onPressed: widget.onBack,
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Retour',
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4),
          child: LinearProgressIndicator(value: 2 / 3),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Profil professionnel',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Présentez votre expérience professionnelle.',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 28),

                TextFormField(
                  controller: _professionController,
                  decoration: _decoration('Profession'),
                  textCapitalization: TextCapitalization.words,
                  validator: Validators.validateProfession,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _experienceController,
                  decoration: _decoration('Années d’expérience'),
                  keyboardType: TextInputType.number,
                  validator: Validators.validateExperience,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _tjmController,
                  decoration: _decoration('TJM (€)').copyWith(prefixText: '€ '),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: Validators.validateTjm,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _biographieController,
                  decoration: _decoration('Biographie').copyWith(
                    alignLabelWithHint: true,
                    helperText:
                        '${_biographieController.text.length}/300 caractères',
                  ),
                  maxLines: 5,
                  maxLength: 300,
                  onChanged: (_) => setState(() {}),
                  validator: Validators.validateBiographie,
                ),
                const SizedBox(height: 28),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: widget.onBack,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Retour'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _goToNextStep,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Suivant'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
