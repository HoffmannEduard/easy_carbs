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
            loading: () => const Center (child: CircularProgressIndicator(),),
            error: (err, st) => Center(child: Text('$err'),),
            data: (settings) {
              _selectedUnits = CarbUnit.values.map((e) => e == settings.carbUnit).toList();
              _carbUnitFactorController.text = settings.carbFactor?.toString() ?? '';
              _fpeFactorController.text = settings.fpeFactor?.toString() ?? '';
              
      
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Persönliche Einstellungen',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontStyle: FontStyle.italic
                          ),),
                      ],
                    ),
                    SizedBox(height: 20,),
                    // Carb Unit Selection
                    ToggleButtons(
                      isSelected: _selectedUnits,
                      onPressed: (index) {
                        ref.read(userSettingsNotifierProvider.notifier)
                          .setCarbUnit(CarbUnit.values[index]);
                      },
                      children: CarbUnit.values.map((unit) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(unit.label),
                      )).toList(),
                    ),
                    SizedBox(height: 30,),
                    // Insulin Factor Input Field
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 150,
                          child: TextFormField(
                            controller: _carbUnitFactorController,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              labelText: 'Insulin-faktor',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12))
                              )
                            ),
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final value = double.tryParse(_carbUnitFactorController.text);
                              if (value != null) {
                                ref.read(userSettingsNotifierProvider.notifier)
                                  .setCarbFactor(value);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Bitte gültige Zahl eingeben'))
                                  );
                              }
                          }, 
                          child: Text('Speichern')
                          )
                      ],
                    ),
                    SizedBox(height: 20,),
                    // Toggle show FPE-Units
                    SwitchListTile(
                      title: const Text('FPE anzeigen'),
                      value: settings.showFpe,
                      onChanged: (value) {
                        ref.read(userSettingsNotifierProvider.notifier).toggleShowFpe(value);
                      },
                    ),
                    SizedBox(height: 10,),
                    // FPE Factor Input Field
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
                              labelText: 'FPE-faktor',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12))
                              )
                            ),
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final value = double.tryParse(_fpeFactorController.text);
                              if (value != null) {
                                ref.read(userSettingsNotifierProvider.notifier)
                                  .setFpeFactor(value);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Bitte gültige Zahl eingeben'))
                                  );
                              }
                          }, 
                          child: Text('Speichern')
                          )
                      ],
                    ),
                  ],
                ),
              );
            }
      
          ),
          ),
      ),
    );
  }
}