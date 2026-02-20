import 'package:flutter/material.dart';

/// Eingabefeld für den Ort einer Mahlzeit.
///
/// - Übergibt den getrimmten Text über [onCommit].
/// - Commit erfolgt bei "Done" oder beim Verlassen des Feldes.
class LocationSection extends StatelessWidget {
  const LocationSection({
    super.key,
    required this.location,
    required this.onCommit,
  });

  final String? location;
  final Future<void> Function(String?) onCommit;

  Future<void> _openEditDialog(BuildContext context) async {
    final dialogController =
        TextEditingController(text: location ?? '');

    // Cursor ans Ende setzen (besseres UX)
    dialogController.selection = TextSelection.fromPosition(
      TextPosition(offset: dialogController.text.length),
    );

    final result = await showDialog<String>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Ort bearbeiten'),
          content: TextField(
            controller: dialogController,
            autofocus: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) =>
                Navigator.of(ctx).pop(dialogController.text),
            decoration: const InputDecoration(
              labelText: 'Ort',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Abbrechen'),
            ),
            FilledButton(
              onPressed: () =>
                  Navigator.of(ctx).pop(dialogController.text),
              child: const Text('Speichern'),
            ),
          ],
        );
      },
    );

    if (result == null) return;

    final trimmed = result.trim();

    // Falls leer → null speichern
    final newValue = trimmed.isEmpty ? null : trimmed;

    if (newValue == location) return;

    await onCommit(newValue);
  }

  @override
  Widget build(BuildContext context) {
    final display =
        (location == null || location!.trim().isEmpty)
            ? 'Ort hinzufügen'
            : location!.trim();

    final isPlaceholder =
        location == null || location!.trim().isEmpty;

    return InkWell(
  onTap: () => _openEditDialog(context),
  borderRadius: BorderRadius.circular(8),
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.place,
          size: 20,
          color: isPlaceholder
              ? Theme.of(context).hintColor
              : Theme.of(context).iconTheme.color,
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            display,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isPlaceholder
                      ? Theme.of(context).hintColor
                      : null,
                ),
          ),
        ),
      ],
    ),
  ),
);
  }
}