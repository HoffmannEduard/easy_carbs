import 'dart:async';
import 'package:easy_carbs/app/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Eingabebereich für BE/KE-Wert einer Mahlzeit.
///
/// - Änderungen werden debounced gespeichert (350 ms), um zu häufige Writes zu vermeiden.
/// - Bei "Done" wird sofort gespeichert.
/// - Im Readonly-Modus sind Eingabe und Callbacks deaktiviert.
class BESection extends StatefulWidget {
  const BESection({
    super.key,
    required this.controller,
    required this.unitLabel,
    required this.onCommit,
    required this.readonly,
    this.debounce = const Duration(milliseconds: 350),
  });

  final TextEditingController controller;
  final String unitLabel;
  final Future<void> Function(double? value) onCommit; 
  final bool readonly;
  final Duration debounce;

  @override
  State<BESection> createState() => _BESectionState();
}

class _BESectionState extends State<BESection> {
  Timer? _timer;

  double? _parse() {
    final text = widget.controller.text.trim().replaceAll(',', '.');
    if (text.isEmpty) return null;
    return double.tryParse(text);
  }

  Future<void> _commitNow() async {
    final value = _parse();
    await widget.onCommit(value);
  }

  void _scheduleCommit(String _) {
    _timer?.cancel();
    _timer = Timer(widget.debounce, () {
      widget.onCommit(_parse());
    });
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
              decoration: InputDecoration(hintText: '--', filled: !widget.readonly),
              textInputAction: TextInputAction.done,

              // Live commit (debounced)
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
        Text(widget.unitLabel, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
