import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:easy_carbs/app/provider/drift_db_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DbViewerButton extends ConsumerWidget {
  const DbViewerButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.read(driftDbProvider); // <-- hier bekommst du die DB

    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DriftDbViewer(db),
        ));
      },
      child: const Text('DB Viewer öffnen'),
    );
  }
}
