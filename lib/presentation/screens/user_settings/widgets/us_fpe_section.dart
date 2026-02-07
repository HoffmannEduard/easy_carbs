import 'package:flutter/material.dart';

class UsFpeSection extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;

  const UsFpeSection({
    super.key,
    required this.controller,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
