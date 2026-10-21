import 'package:flutter_test/flutter_test.dart';
import 'package:ma_biblio/main.dart';

void main() {
  testWidgets('MaBiblio affiche le titre de l application', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaBiblioApp());

    expect(find.text('MaBiblio'), findsOneWidget);
  });
}
