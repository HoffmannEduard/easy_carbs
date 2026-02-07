import 'package:easy_carbs/app/theme/app_spacing.dart';
import 'package:easy_carbs/presentation/screens/insulin_factor_edit/insulin_factor_edit_screen.dart';
import 'package:easy_carbs/presentation/screens/user_settings/widgets/carb_unit_toggle.dart';
import 'package:easy_carbs/presentation/screens/user_settings/widgets/us_fpe_section.dart';
import 'package:easy_carbs/presentation/state/user_settings/user_settings_async_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/insulin_factors_table.dart';

class UserSettingsScreen extends ConsumerStatefulWidget {
  const UserSettingsScreen({super.key});

  @override
  ConsumerState<UserSettingsScreen> createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends ConsumerState<UserSettingsScreen> {
  final _fpeFactorController = TextEditingController();
  bool _fpeInitialized = false;

  @override
  void dispose() {
    _fpeFactorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingsAsync = ref.watch(userSettingsNotifierProvider);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Persönliche Einstellungen')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: settingsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, st) => Center(child: Text('$err')),
            data: (settings) {
              if (!_fpeInitialized) {
                _fpeFactorController.text = settings.fpeFactor?.toString() ?? '';
                _fpeInitialized = true;
              }

              return ListView(
                children: [
                  // Toggle ShowInsulin
                  SwitchListTile(
                    title: const Text('Insulin anzeigen'),
                    subtitle: const Text('Blendet Insulin-Felder bei Mahlzeiten ein oder aus'),
                    value: settings.showInsulin,
                    onChanged: (value) {
                      ref.read(userSettingsNotifierProvider.notifier).toggleShowInsulin(value);
                    },
                  ),
                  const SizedBox(height: AppSpacing.spacingLg),

                  // Insulin Faktor Tabelle
                  if (settings.showInsulin)
                    InsulinFactorsTable(
                      insulinFactors: settings.insulinFactors,
                      onEdit: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const InsulinFactorsEditScreen()),
                        );
                      },
                    ),
                  const SizedBox(height: AppSpacing.spacingLg),

                  // FPE Section
                  if (settings.showInsulin)
                    UsFpeSection(
                      controller: _fpeFactorController,
                      onCommit: (value) {
                        if (value == null && _fpeFactorController.text.trim().isNotEmpty) {
                          return;
                        }
                        ref.read(userSettingsNotifierProvider.notifier).setFpeFactor(value);
                      },
                    ),

                  const SizedBox(height: AppSpacing.spacingLg),

                  CarbUnitToggle(
                    selected: settings.carbUnit,
                    onSelected: (unit) =>
                        ref.read(userSettingsNotifierProvider.notifier).setCarbUnit(unit),
                  ),
                  const SizedBox(height: AppSpacing.spacingLg),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
