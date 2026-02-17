import 'dart:async';
import 'package:easy_carbs/app/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Eingabebereich für den FPE-Wert einer Mahlzeit.
///
/// - Änderungen werden debounced gespeichert (350 ms).
/// - Bei "Done" erfolgt sofortiges Commit.
/// - Im Readonly-Modus ist die Eingabe deaktiviert.
class FPESection extends StatefulWidget {
  const FPESection({
    super.key,
    required this.controller,
    required this.onCommit,
    required this.readonly,
    this.debounce = const Duration(milliseconds: 350),
  });

  final TextEditingController controller;
  final Future<void> Function(double? value) onCommit; 
  final bool readonly;
  final Duration debounce;

  @override
  State<FPESection> createState() => _FPESectionState();
}

class _FPESectionState extends State<FPESection> {
  Timer? _timer;

  double? _parse() {
    final text = widget.controller.text.trim().replaceAll(',', '.');
    if (text.isEmpty) return null;
    return double.tryParse(text);
  }

  void _scheduleCommit(String _) {
    _timer?.cancel();
    _timer = Timer(widget.debounce, () {
      widget.onCommit(_parse());
    });
  }

  Future<void> _commitNow() async {
    await widget.onCommit(_parse());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 50),
          child: IntrinsicWidth(
            child: TextField(
              textAlign: TextAlign.center,
              controller: widget.controller,
              readOnly: widget.readonly,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: '--',
                filled: !widget.readonly,
              ),
              textInputAction: TextInputAction.done,

              // Live speichern (debounced)
              onChanged: widget.readonly ? null : _scheduleCommit,

              // Done => sofort commit
              onSubmitted: widget.readonly
                  ? null
                  : (_) async {
                      _timer?.cancel();
                      await _commitNow();
                    },
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.spacingSm),
        Text('FPE', style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
