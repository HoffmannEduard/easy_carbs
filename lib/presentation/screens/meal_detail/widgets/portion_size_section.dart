import 'package:easy_carbs/app/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class PortionSizeSection extends StatefulWidget {
  const PortionSizeSection({
    super.key,
    required this.controller,
    required this.unitLabel,
    required this.onCommit,
  });

  final TextEditingController controller;
  final String unitLabel;
  final ValueChanged<double?> onCommit;

  @override
  State<PortionSizeSection> createState() => _PortionSizeSectionState();
}

class _PortionSizeSectionState extends State<PortionSizeSection> {
  late final FocusNode _focusNode;
  String _lastCommittedText = '';

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    // Commit bei Fokusverlust (User tippt woanders hin / Next / etc.)
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _commitIfChanged();
      }
    });

    // Initialer Referenzwert, damit wir nicht sofort "changed" sind.
    _lastCommittedText = widget.controller.text;
  }

  @override
  void didUpdateWidget(covariant PortionSizeSection oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Falls du den Controller austauschst, musst du den Commit-Cache aktualisieren.
    if (oldWidget.controller != widget.controller) {
      _lastCommittedText = widget.controller.text;
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _commitIfChanged() {
    final raw = widget.controller.text;
    if (raw == _lastCommittedText) return;

    _lastCommittedText = raw;

    final text = raw.trim().replaceAll(',', '.');
    final value = text.isEmpty ? null : double.tryParse(text);

    widget.onCommit(value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 50),
          child: IntrinsicWidth(
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(hintText: '--'),

              // Commit wenn User bestätigt (Done/Enter)
              onSubmitted: (_) {
                _commitIfChanged();
                FocusScope.of(context).unfocus();
              },

              // Optional zusätzlich: Tap außerhalb (falls verfügbar)
              onTapOutside: (_) {
                _commitIfChanged();
                FocusScope.of(context).unfocus();
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
