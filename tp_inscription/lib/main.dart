import 'package:flutter/material.dart';

import 'models/user_profile.dart';
import 'screens/step_one_screen.dart';
import 'screens/step_two_screen.dart';
import 'screens/summary_screen.dart';

void main() {
  runApp(const InscriptionApp());
}

class InscriptionApp extends StatelessWidget {
  const InscriptionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inscription',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3563E9)),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF1E293B),
          elevation: 0,
        ),
      ),
      home: const RegistrationFlow(),
    );
  }
}

class RegistrationFlow extends StatefulWidget {
  const RegistrationFlow({super.key});

  @override
  State<RegistrationFlow> createState() => _RegistrationFlowState();
}

class _RegistrationFlowState extends State<RegistrationFlow> {
  int _currentStep = 0;
  UserProfile _profile = const UserProfile();

  void _goToStepTwo(UserProfile profile) {
    setState(() {
      _profile = profile;
      _currentStep = 1;
    });
  }

  void _goToStepThree(UserProfile profile) {
    setState(() {
      _profile = profile;
      _currentStep = 2;
    });
  }

  void _goBackToStepOne() {
    setState(() {
      _currentStep = 0;
    });
  }

  void _goBackToStepTwo() {
    setState(() {
      _currentStep = 1;
    });
  }

  void _resetRegistration() {
    setState(() {
      _profile = const UserProfile();
      _currentStep = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_currentStep) {
      case 0:
        return StepOneScreen(initialProfile: _profile, onNext: _goToStepTwo);

      case 1:
        return StepTwoScreen(
          initialProfile: _profile,
          onNext: _goToStepThree,
          onBack: _goBackToStepOne,
        );

      default:
        return SummaryScreen(
          profile: _profile,
          onBack: _goBackToStepTwo,
          onReset: _resetRegistration,
        );
    }
  }
}
