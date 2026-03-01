import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:easy_carbs/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('E2E: Mahlzeit erstellen -> Weiterleitung auf DetailScreen', (tester) async {
    // Given: App starten
    app.main();
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('home_addMeal_button')));
    await tester.pumpAndSettle();

    // When: Formular ausfüllen
    final mealName = 'Test-Pizza';

    await tester.enterText(find.byKey(const Key('addMeal_name_field')), mealName);

    // PortionUnit setzen (Dropdown o.ä.)
    await tester.tap(find.byKey(const Key('addMeal_portionUnit_field')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Gewicht').last);
    await tester.pumpAndSettle();

    // Speichern
    await tester.tap(find.byKey(const Key('addMeal_create_button')));
    await tester.pumpAndSettle();

    expect(find.text(mealName), findsOneWidget);
  });
}