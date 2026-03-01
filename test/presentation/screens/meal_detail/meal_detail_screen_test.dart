import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:easy_carbs/presentation/screens/meal_detail/meal_detail_screen.dart';
import 'package:easy_carbs/presentation/screens/meal_detail/widgets/insulin_units_card.dart';

import 'package:easy_carbs/domain/entities/meal.dart';
import 'package:easy_carbs/domain/entities/nutrition.dart';
import 'package:easy_carbs/domain/entities/portion_unit.dart';
import 'package:easy_carbs/domain/entities/carb_unit.dart';
import 'package:easy_carbs/domain/entities/user_settings.dart';
import 'package:easy_carbs/domain/entities/fixed_insulin_factors.dart';
import 'package:easy_carbs/domain/entities/time_based_insulin_factor.dart';
import 'package:easy_carbs/domain/entities/insulin_block_id.dart';

import 'package:easy_carbs/presentation/state/meals/meal_provider.dart';
import 'package:easy_carbs/presentation/state/user_settings/user_settings_async_notifier.dart';
import 'package:easy_carbs/presentation/state/meals/meal_detail/meal_insulin_units_provider.dart';
import '../../fake_provider/test_user_settings_async_notifier.dart';

void main() {
  Meal givenMeal({required String id, required bool autocalculate}) {
    return Meal(
      id: id,
      name: 'Pizza',
      carbUnit: CarbUnit.be,
      autocalculate: autocalculate,
      carbsInUnit: 2.0,
      fpe: 1.3,
      nutrition: Nutrition(carbs: 24, fat: 10, protein: 10),
      portionsize: 100,
      portionUnit: PortionUnit.gramm,
      location: 'Zuhause',
      note: 'Testnotiz',
    );
  }

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

  group('MealDetailScreen (Widget)', () {
  testWidgets(
    'zeigt Mahlzeitdaten UND InsulinUnitsCard wenn alle Provider Daten liefern',
    (tester) async {
      // Given
      const mealId = 'm1';
      final meal = givenMeal(id: mealId, autocalculate: false);
      final settings = givenSettings(showInsulin: true);

      final insulin = MealInsulinUnits(
        carbsUnits: 3.0,
        fpeUnits: 1.3,
        now: const TimeOfDay(hour: 12, minute: 0),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            mealByIdProvider(mealId)
                .overrideWith((ref) => AsyncValue.data(meal)),

            userSettingsNotifierProvider.overrideWith(
              () => TestUserSettingsAsyncNotifier(settings),
            ),

            mealInsulinUnitsProvider(mealId)
                .overrideWith((ref) => AsyncValue.data(insulin)),
          ],
          child: const MaterialApp(
            home: MealDetailScreen(mealId: mealId),
          ),
        ),
      );

      // When
      await tester.pumpAndSettle();

      // Then – Meal-Daten
      expect(find.text('Pizza'), findsOneWidget);
      expect(find.text('Zuhause'), findsOneWidget);
      expect(find.textContaining('2.0'), findsWidgets); // carbsInUnit
      expect(find.textContaining('1.3'), findsWidgets); // fpe

      // Then – InsulinCards
      expect(find.byType(InsulinUnitsCard), findsNWidgets(2));
    },
  );
});
}
