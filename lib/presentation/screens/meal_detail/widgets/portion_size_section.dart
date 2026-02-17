import 'package:easy_carbs/app/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Eingabekomponente zur Bearbeitung der Portionsgröße.
///
/// Eigenschaften:
/// - Commit erfolgt nur bei tatsächlicher Wertänderung.
/// - Speicherung bei:
///     - Fokusverlust
///     - "Done"-Action
///     - Tap außerhalb des Feldes
/// - Verhindert unnötige Repository-/State-Updates durch internen Vergleich mit dem zuletzt committeten Textwert.
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

    // Initialer Referenzwert
    _lastCommittedText = widget.controller.text;
  }

  @override
  void didUpdateWidget(covariant PortionSizeSection oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Falls Controller austauscht wird, Commit-Cache aktualisieren.
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
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    // Statisch, nicht fokusabhängig
    final bg = cs.surfaceContainerHigh;
    final fg = cs.onSurfaceVariant;
    final border = cs.outlineVariant;

    return InkWell(
      onTap: () => _focusNode.requestFocus(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: border, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.edit, size: 16, color: fg),
            const SizedBox(width: 6),
      
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 56),
              child: IntrinsicWidth(
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  textAlign: TextAlign.center,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  textInputAction: TextInputAction.done,
                  style: theme.textTheme.titleMedium?.copyWith(color: fg),
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: '--',
                    border: InputBorder.none,
                    filled: false,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 6,
                    ),
                    hintStyle: theme.textTheme.titleMedium?.copyWith(
                      color: fg.withAlpha(140),
                    ),
                  ),
                  onSubmitted: (_) {
                    _commitIfChanged();
                    FocusScope.of(context).unfocus();
                  },
                  onTapOutside: (_) {
                    _commitIfChanged();
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
            ),
      
            const SizedBox(width: AppSpacing.spacingSm),
            Text(
              widget.unitLabel,
              style: theme.textTheme.titleMedium?.copyWith(color: fg),
            ),
          ],
        ),
      ),
    );
  }
}
