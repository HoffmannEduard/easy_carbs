import 'package:easy_carbs/domain/entities/carb_unit.dart';
import 'package:flutter/material.dart';
import 'package:easy_carbs/domain/entities/meal.dart';

/// Abschnitt zur Aktivierung der automatischen BE/FPE-Berechnung.
///
/// - Aktivierung nur möglich, wenn Portionsgröße und Nährwerte vorhanden sind.
/// - Bestehende Werte werden bei Aktivierung ggf. nach Bestätigung überschrieben.
///
/// Fehler werden als SnackBar angezeigt.
class AutoCalculateSection extends StatefulWidget {
  const AutoCalculateSection({
    super.key,
    required this.meal,
    required this.onToggleAutocalculate,
    required this.onRunAutocalc,
  });

  final Meal meal;
  final Future<void> Function(bool value) onToggleAutocalculate;
  final Future<void> Function() onRunAutocalc;

  @override
  State<AutoCalculateSection> createState() =>
      _AutocalculateSectionState();
}

class _AutocalculateSectionState extends State<AutoCalculateSection> {

  void _showSnack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final meal = widget.meal;

    final canAutoCalc = meal.portionsize != null && meal.nutrition != null;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Automatisch berechnen',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Switch(
          value: meal.autocalculate,
          onChanged: (value) async {
            FocusManager.instance.primaryFocus?.unfocus();
            // Ausschalten → direkt
            if (!value) {
              try {
                await widget.onToggleAutocalculate(false);
              } catch (e) {
                _showSnack(e.toString());
              }
              return;
            }

            // Einschalten → zuerst Preconditions prüfen
            if (!canAutoCalc) {
              _showSnack('Portionsgröße und Nährwerte erforderlich');
              return;
            }

            // Einschalten → Warnung bei Überschreiben
            final wouldOverwrite = meal.carbsInUnit != null || meal.fpe != null;

            if (wouldOverwrite) {
              final proceed = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Werte berechnen'),
                  content: Text(
                    'Existierende ${meal.carbUnit.label} und FPE werden überschrieben.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Abbrechen'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Aktivieren'),
                    ),
                  ],
                ),
              );

              if (proceed != true) return;
            }

            try {
              await widget.onToggleAutocalculate(true);
              await widget.onRunAutocalc();
            } catch (e) {
              _showSnack(e.toString());
            }
          },
        ),

      ],
    );
  }
}
