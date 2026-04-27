// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:eveil_enfants/main.dart';

void main() {
  testWidgets('Affiche les themes et la grille', (WidgetTester tester) async {
    await tester.pumpWidget(const EveilEnfantsApp());

    expect(find.text('Choisis un thème'), findsOneWidget);
    expect(find.text('Animaux'), findsWidgets);
    expect(find.text('Flore'), findsOneWidget);
    expect(find.text('Objets'), findsOneWidget);
    expect(find.text('Nourriture'), findsOneWidget);
    expect(find.text('Transports'), findsOneWidget);
    expect(find.byType(ThemeButton), findsWidgets);
  });
}
