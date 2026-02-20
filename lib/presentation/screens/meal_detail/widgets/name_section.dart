import 'package:flutter/material.dart';

/// Eingabefeld für den Namen einer Mahlzeit.
///
/// - Übergibt den getrimmten Text über [onCommit].
/// - Commit erfolgt bei "Done" oder beim Verlassen des Feldes.
class NameSection extends StatelessWidget {
  const NameSection({
    super.key,
    required this.name,
    required this.onCommit,
  });

  final String name;
  final ValueChanged<String> onCommit;

  Future<void> _openEditDialog(BuildContext context) async {
    final dialogController = TextEditingController(text: name);

    final result = await showDialog<String>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Mahlzeit umbenennen'),
          content: TextField(
            controller: dialogController,
            autofocus: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => Navigator.of(ctx).pop(dialogController.text),
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Abbrechen'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(ctx).pop(dialogController.text),
              child: const Text('Speichern'),
            ),
          ],
        );
      },
    );

    if (result == null) return;
    final trimmed = result.trim();
    if (trimmed.isEmpty || trimmed == name.trim()) return;

    onCommit(trimmed);
  }

  @override
  Widget build(BuildContext context) {
    final mealName = name.trim().isEmpty ? 'Ohne Namen' : name.trim();

    return InkWell(
      onTap: () => _openEditDialog(context),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Text(
          mealName,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}