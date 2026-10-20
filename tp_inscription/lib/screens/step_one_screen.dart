import 'package:flutter/material.dart';

import '../models/user_profile.dart';
import '../utils/validators.dart';

class StepOneScreen extends StatefulWidget {
  final UserProfile initialProfile;
  final ValueChanged<UserProfile> onNext;

  const StepOneScreen({
    super.key,
    this.initialProfile = const UserProfile(),
    required this.onNext,
  });

  @override
  State<StepOneScreen> createState() => _StepOneScreenState();
}

class _StepOneScreenState extends State<StepOneScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nomController;
  late final TextEditingController _prenomController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmationController;

  bool _hidePassword = true;
  bool _hideConfirmation = true;

  @override
  void initState() {
    super.initState();

    _nomController = TextEditingController(text: widget.initialProfile.nom);
    _prenomController = TextEditingController(
      text: widget.initialProfile.prenom,
    );
    _emailController = TextEditingController(text: widget.initialProfile.email);
    _passwordController = TextEditingController(
      text: widget.initialProfile.password,
    );
    _confirmationController = TextEditingController(
      text: widget.initialProfile.password,
    );
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmationController.dispose();
    super.dispose();
  }

  void _goToNextStep() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final profile = widget.initialProfile.copyWith(
      nom: _nomController.text.trim(),
      prenom: _prenomController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
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
        title: const Text('Inscription - Étape 1/3'),
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4),
          child: LinearProgressIndicator(value: 1 / 3),
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
                  'Informations personnelles',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Veuillez renseigner vos informations pour continuer.',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 28),

                TextFormField(
                  controller: _nomController,
                  decoration: _decoration(
                    'Nom',
                  ).copyWith(prefixIcon: const Icon(Icons.person_outline)),
                  textCapitalization: TextCapitalization.words,
                  validator: Validators.validateNom,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _prenomController,
                  decoration: _decoration(
                    'Prénom',
                  ).copyWith(prefixIcon: const Icon(Icons.person_outline)),
                  textCapitalization: TextCapitalization.words,
                  validator: Validators.validatePrenom,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _emailController,
                  decoration: _decoration(
                    'E-mail',
                  ).copyWith(prefixIcon: const Icon(Icons.email_outlined)),
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _passwordController,
                  obscureText: _hidePassword,
                  decoration: _decoration('Mot de passe').copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _hidePassword ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _hidePassword = !_hidePassword;
                        });
                      },
                    ),
                  ),
                  validator: Validators.validatePassword,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _confirmationController,
                  obscureText: _hideConfirmation,
                  decoration: _decoration('Confirmer le mot de passe').copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _hideConfirmation
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _hideConfirmation = !_hideConfirmation;
                        });
                      },
                    ),
                  ),
                  validator: (value) => Validators.validateConfirmation(
                    value,
                    _passwordController.text,
                  ),
                ),
                const SizedBox(height: 28),

                ElevatedButton(
                  onPressed: _goToNextStep,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Suivant'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
