import 'package:easy_carbs/app/provider/notifier/user_settings_async_notifier.dart';
import 'package:easy_carbs/domain/entities/carb_unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsInputWidget extends ConsumerStatefulWidget {
  const UsInputWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UsInputWidgetState();
}

class _UsInputWidgetState extends ConsumerState<UsInputWidget> {

  final _formKey = GlobalKey<FormState>();
  final _carbUnitFactorController = TextEditingController();
  final _fpeFactorController = TextEditingController();
  bool testToggle = false;


  @override
  Widget build(BuildContext context) {

    final settingsAsync = ref.watch(userSettingsNotifierProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: settingsAsync.when(
          loading: () => const Center (child: CircularProgressIndicator(),),
          error: (err, st) => Center(child: Text('$err'),),
          data: (settings) {
            _carbUnitFactorController.text = settings.carbFactor?.toString() ?? '';
            _fpeFactorController.text = settings.fpeFactor?.toString() ?? '';
            

            return Form(
              key: _formKey,
              child: Column(
                children: [
                  DropdownButtonFormField<CarbUnit>(
                    value: settings.carbUnit,
                    items: CarbUnit.values.map((unit) {
                      return DropdownMenuItem<CarbUnit>(
                        value: unit,
                        child: Text(unit.label),
                      );
                    }).toList(),
                    onChanged: (unit) {
                      // Handle unit change
                    }
                    ),
                  TextFormField(
                    controller: _carbUnitFactorController,
                    decoration: const InputDecoration(
                      labelText: 'Insulin-faktor',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SwitchListTile(
                    title: const Text('FPE anzeigen'),
                    value: settings.showFpe,
                    onChanged: (value) {
                      ref.read(userSettingsNotifierProvider.notifier).toggleShowFpe(value);
                    },
                  ),
                  TextFormField(
                    controller: _fpeFactorController,
                    decoration: const InputDecoration(
                      labelText: 'FPE-Faktor',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            );
          }

        ),
        ),
    );
  }
}