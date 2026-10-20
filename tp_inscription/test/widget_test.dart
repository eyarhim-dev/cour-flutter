import 'package:flutter_test/flutter_test.dart';
import 'package:tp_inscription/main.dart';

void main() {
  testWidgets('L’application affiche la première étape', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const InscriptionApp());

    expect(find.text('Inscription - Étape 1/3'), findsOneWidget);
    expect(find.text('Informations personnelles'), findsOneWidget);
    expect(find.text('Nom'), findsOneWidget);
    expect(find.text('Prénom'), findsOneWidget);
    expect(find.text('Suivant'), findsOneWidget);
  });
}
