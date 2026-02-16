import 'package:flutter/material.dart';

class DeleteMealButton extends StatefulWidget {
  final Future<void> Function() onDelete;

  const DeleteMealButton({
    super.key,
    required this.onDelete,
  });

  @override
  State<DeleteMealButton> createState() => _DeleteMealButtonState();
}

class _DeleteMealButtonState extends State<DeleteMealButton> {
  bool _busy = false;

  Future<void> _confirmAndDelete() async {
    if (_busy) return;

    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Mahlzeit endgültig löschen?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(false),
            child: const Text('Abbrechen'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            onPressed: () => Navigator.of(dialogCtx).pop(true),
            child: const Text('Löschen'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _busy = true);
    try {
      await widget.onDelete();

      if (mounted) Navigator.of(context).pop();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Align(
      alignment: Alignment.centerLeft,
      child: IntrinsicWidth(
        child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: cs.error,
                foregroundColor: cs.onError,
                padding: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _busy ? null : _confirmAndDelete,
              child: _busy
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(Icons.delete),
            ),
      ),
    );
  }
}
