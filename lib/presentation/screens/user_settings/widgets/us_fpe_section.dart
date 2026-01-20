import 'package:flutter/material.dart';

class UsFpeSection extends StatelessWidget {
  final bool showFpe;
  final TextEditingController controller;
  final ValueChanged<bool> onToggle;
  final VoidCallback onSave;

  const UsFpeSection({
    super.key,
    required this.showFpe,
    required this.controller,
    required this.onToggle,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
          title: const Text('FPE anzeigen'),
          value: showFpe,
          onChanged: onToggle,
          contentPadding: EdgeInsets.zero,
        ),
        if (showFpe)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 160,
                child: TextFormField(
                  controller: controller,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(labelText: 'FPE-Faktor'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              ElevatedButton(
                onPressed: onSave,
                child: const Text('Speichern'),
              ),
            ],
          ),
      ],
    );
  }
}
