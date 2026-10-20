class Validators {
  static String? validateNom(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Le nom est obligatoire';
    }

    final nom = value.trim();

    if (nom.length < 2) {
      return 'Le nom doit contenir au moins 2 caractères';
    }

    if (!RegExp(r"^[A-Za-zÀ-ÖØ-öø-ÿ' -]+$").hasMatch(nom)) {
      return 'Le nom contient des caractères non valides';
    }

    return null;
  }

  static String? validatePrenom(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Le prénom est obligatoire';
    }

    final prenom = value.trim();

    if (prenom.length < 2) {
      return 'Le prénom doit contenir au moins 2 caractères';
    }

    if (!RegExp(r"^[A-Za-zÀ-ÖØ-öø-ÿ' -]+$").hasMatch(prenom)) {
      return 'Le prénom contient des caractères non valides';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'L’e-mail est obligatoire';
    }

    final emailRegex = RegExp(
      r'^[\w.+-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Veuillez saisir un e-mail valide';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le mot de passe est obligatoire';
    }

    if (value.length < 8) {
      return '8 caractères minimum';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Au moins une lettre majuscule';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Au moins un chiffre';
    }

    return null;
  }

  static String? validateConfirmation(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Veuillez confirmer le mot de passe';
    }

    if (value != password) {
      return 'Les mots de passe ne correspondent pas';
    }

    return null;
  }

  static String? validateProfession(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'La profession est obligatoire';
    }

    if (value.trim().length < 2) {
      return 'La profession doit contenir au moins 2 caractères';
    }

    return null;
  }

  static String? validateExperience(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'L’expérience est obligatoire';
    }

    final experience = int.tryParse(value.trim());

    if (experience == null || experience < 0 || experience > 50) {
      return 'Veuillez saisir un nombre entre 0 et 50';
    }

    return null;
  }

  static String? validateTjm(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Le TJM est obligatoire';
    }

    final tjm = double.tryParse(value.trim().replaceAll(',', '.'));

    if (tjm == null || tjm < 50 || tjm > 3000) {
      return 'Le TJM doit être compris entre 50 et 3000';
    }

    return null;
  }

  static String? validateBiographie(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final biographie = value.trim();

    if (biographie.length < 20) {
      return 'La biographie doit contenir au moins 20 caractères';
    }

    if (biographie.length > 300) {
      return '300 caractères maximum';
    }

    return null;
  }
}
