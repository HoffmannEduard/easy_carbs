import 'package:easy_carbs/presentation/screens/user_settings/widgets/insulin_factors_table.dart';
import 'package:easy_carbs/presentation/screens/user_settings/widgets/us_fpe_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:easy_carbs/presentation/screens/user_settings/user_settings_screen.dart';
import 'package:easy_carbs/presentation/state/user_settings/user_settings_async_notifier.dart';

import 'package:easy_carbs/domain/entities/user_settings.dart';
import 'package:easy_carbs/domain/entities/carb_unit.dart';
import 'package:easy_carbs/domain/entities/fixed_insulin_factors.dart';
import 'package:easy_carbs/domain/entities/time_based_insulin_factor.dart';
import 'package:easy_carbs/domain/entities/insulin_block_id.dart';

import '../../fake_provider/test_user_settings_async_notifier.dart';

void main() {
  UserSettings givenSettings({required bool showInsulin}) {
    final factors = FixedInsulinFactors(
      morning: TimeBasedInsulinFactor(
        id: InsulinBlockId.morning.key,
        startTime: const TimeOfDay(hour: 6, minute: 0),
        endTime: const TimeOfDay(hour: 12, minute: 0),
        insulinFactor: 1.0,
      ),
      midday: TimeBasedInsulinFactor(
        id: InsulinBlockId.midday.key,
        startTime: const TimeOfDay(hour: 12, minute: 0),
        endTime: const TimeOfDay(hour: 18, minute: 0),
        insulinFactor: 1.0,
      ),
      evening: TimeBasedInsulinFactor(
        id: InsulinBlockId.evening.key,
        startTime: const TimeOfDay(hour: 18, minute: 0),
        endTime: const TimeOfDay(hour: 22, minute: 0),
        insulinFactor: 1.0,
      ),
      night: TimeBasedInsulinFactor(
        id: InsulinBlockId.night.key,
        startTime: const TimeOfDay(hour: 22, minute: 0),
        endTime: const TimeOfDay(hour: 6, minute: 0),
        insulinFactor: 1.0,
      ),
    );

    return UserSettings(
      id: 'user',
      carbUnit: CarbUnit.be,
      insulinFactors: factors,
      showInsulin: showInsulin,
      fpeFactor: 1.0,
    );
  }

  group('UserSettingsScreen (Widget)', () {
    testWidgets('toggleShowInsulin aktualisiert Switch und blendet Insulin-Sektionen ein', (tester) async {
      // Given
      final notifier = TestUserSettingsAsyncNotifier(givenSettings(showInsulin: false));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userSettingsNotifierProvider.overrideWith(() => notifier),
          ],
          child: const MaterialApp(home: UserSettingsScreen()),
        ),
      );

      // erster Frame -> Fake setzt state=AsyncData
      await tester.pump();

      final tileFinder = find.byKey(const Key('showInsulin_switch'));
      expect(tileFinder, findsOneWidget);

      // Then (initial): Switch ist aus, insulin-spezifische Sektionen fehlen
      final tile0 = tester.widget<SwitchListTile>(tileFinder);
      expect(tile0.value, false);
      expect(find.byType(InsulinFactorsTable), findsNothing);
      expect(find.byType(UsFpeSection), findsNothing);

      // When: Toggle an
      await tester.tap(tileFinder);
      await tester.pump();

      // Then: Switch ist an, Sektionen sind sichtbar
      final tile1 = tester.widget<SwitchListTile>(tileFinder);
      expect(tile1.value, true);

      expect(find.byType(InsulinFactorsTable), findsOneWidget);
      expect(find.byType(UsFpeSection), findsOneWidget);
    });
  });
}