import 'package:easy_carbs/app/theme/app_spacing.dart';
import 'package:easy_carbs/presentation/state/user_settings/user_settings_async_notifier.dart';
import 'package:easy_carbs/domain/entities/carb_unit.dart';
import 'package:easy_carbs/domain/entities/time_based_insulin_factor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsInputWidget extends ConsumerStatefulWidget {
  const UsInputWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UsInputWidgetState();
}

class _UsInputWidgetState extends ConsumerState<UsInputWidget> {
  final _formKey = GlobalKey<FormState>();
  final _fpeFactorController = TextEditingController();

  late List<bool> _selectedUnits;

  @override
  Widget build(BuildContext context) {
    final settingsAsync = ref.watch(userSettingsNotifierProvider);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: settingsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, st) => Center(child: Text('$err')),
            data: (settings) {
              _selectedUnits =
                  CarbUnit.values.map((e) => e == settings.carbUnit).toList();
              _fpeFactorController.text =
                  settings.fpeFactor?.toString() ?? '';

              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    // ------------------- Überschrift -------------------
                    Row(
                      children: const [
                        Text(
                          'Persönliche Einstellungen',
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.spacingMd),

                    // ------------------- CarbUnit Toggle -------------------
                    ToggleButtons(
                      isSelected: _selectedUnits,
                      onPressed: (index) {
                        ref
                            .read(userSettingsNotifierProvider.notifier)
                            .setCarbUnit(CarbUnit.values[index]);
                      },
                      children: CarbUnit.values
                          .map((unit) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(unit.label),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: AppSpacing.spacingLg),

                    // ------------------- InsulinFactors -------------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Insulin Faktoren (zeitbasiert)',
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            // Dialog oder neues TimeBasedInsulinFactor hinzufügen
                            final newFactor = await showDialog<TimeBasedInsulinFactor>(
                              context: context,
                              builder: (_) => _InsulinFactorDialog(),
                            );
                            if (newFactor != null) {
                              await ref
                                  .read(userSettingsNotifierProvider.notifier)
                                  .addOrUpdateInsulinFactor(newFactor);
                            }
                          },
                          child: const Text('Hinzufügen'),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.spacingMd),

                    // Liste aller vorhandenen Faktoren
                    Expanded(
                      child: ListView.builder(
                        itemCount: settings.insulinFactors.length,
                        itemBuilder: (context, index) {
                          final factor = settings.insulinFactors[index];
                          return ListTile(
                            title: Text(
                                '${factor.startTime.format(context)} - ${factor.endTime.format(context)}'),
                            subtitle: Text('Faktor: ${factor.insulinFactor}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () async {
                                    final editedFactor =
                                        await showDialog<TimeBasedInsulinFactor>(
                                      context: context,
                                      builder: (_) =>
                                          _InsulinFactorDialog(factor: factor),
                                    );
                                    if (editedFactor != null) {
                                      await ref
                                          .read(userSettingsNotifierProvider.notifier)
                                          .addOrUpdateInsulinFactor(editedFactor);
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    await ref
                                        .read(userSettingsNotifierProvider.notifier)
                                        .deleteInsulinFactor(factor.id);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ------------------- FPE -------------------
                    SwitchListTile(
                      title: const Text('FPE anzeigen'),
                      value: settings.showFpe,
                      onChanged: (value) {
                        ref
                            .read(userSettingsNotifierProvider.notifier)
                            .toggleShowFpe(value);
                      },
                    ),
                    if (settings.showFpe)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 150,
                            child: TextFormField(
                              controller: _fpeFactorController,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                  labelText: 'FPE-Faktor',
                                  ),
                              keyboardType: const TextInputType.numberWithOptions(
                                  decimal: true),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                final value =
                                    double.tryParse(_fpeFactorController.text);
                                if (value != null) {
                                  ref
                                      .read(userSettingsNotifierProvider.notifier)
                                      .setFpeFactor(value);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Bitte gültige Zahl eingeben')));
                                }
                              },
                              child: const Text('Speichern')),
                        ],
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// ------------------- Dialog für InsulinFactor hinzufügen/bearbeiten -------------------
class _InsulinFactorDialog extends StatefulWidget {
  final TimeBasedInsulinFactor? factor;

  const _InsulinFactorDialog({this.factor});

  @override
  State<_InsulinFactorDialog> createState() => _InsulinFactorDialogState();
}

class _InsulinFactorDialogState extends State<_InsulinFactorDialog> {
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  late TextEditingController _factorController;

  @override
  void initState() {
    super.initState();
    _startTime = widget.factor?.startTime ?? const TimeOfDay(hour: 0, minute: 0);
    _endTime = widget.factor?.endTime ?? const TimeOfDay(hour: 1, minute: 0);
    _factorController = TextEditingController(
        text: widget.factor?.insulinFactor.toString() ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.factor == null ? 'Neuer Faktor' : 'Faktor bearbeiten'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Text('Start: '),
              TextButton(
                onPressed: () async {
                  final time = await showTimePicker(context: context, initialTime: _startTime);
                  if (time != null) setState(() => _startTime = time);
                },
                child: Text(_startTime.format(context)),
              ),
            ],
          ),
          Row(
            children: [
              const Text('Ende: '),
              TextButton(
                onPressed: () async {
                  final time = await showTimePicker(context: context, initialTime: _endTime);
                  if (time != null) setState(() => _endTime = time);
                },
                child: Text(_endTime.format(context)),
              ),
            ],
          ),
          TextField(
            controller: _factorController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Faktor'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Abbrechen'),
        ),
        ElevatedButton(
          onPressed: () {
            final value = double.tryParse(_factorController.text);
            if (value != null) {
              final factor = TimeBasedInsulinFactor(
                id: widget.factor?.id ?? UniqueKey().toString(),
                startTime: _startTime,
                endTime: _endTime,
                insulinFactor: value,
              );
              Navigator.of(context).pop(factor);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Bitte gültige Zahl eingeben')));
            }
          },
          child: const Text('Speichern'),
        ),
      ],
    );
  }
}
