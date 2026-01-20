import 'package:easy_carbs/app/utils/time_picker_utils.dart';
import 'package:easy_carbs/domain/entities/fixed_insulin_factors.dart';
import 'package:easy_carbs/domain/entities/insulin_block_id.dart';
import 'package:easy_carbs/domain/services/fixed_insulin_schedule.dart';
import 'package:easy_carbs/presentation/state/user_settings/user_settings_async_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'insulin_block_row.dart';

class InsulinBlocksCard extends ConsumerStatefulWidget {
  final FixedInsulinFactors insulinFactors;

  const InsulinBlocksCard({super.key, required this.insulinFactors});

  @override
  ConsumerState<InsulinBlocksCard> createState() => _InsulinBlocksCardState();
}

class _InsulinBlocksCardState extends ConsumerState<InsulinBlocksCard> {
  late final Map<InsulinBlockId, TextEditingController> _factorControllers;

  @override
  void initState() {
    super.initState();
    _factorControllers = {
      for (final id in InsulinBlockIdX.ordered) id: TextEditingController(),
    };
  }

  @override
  void dispose() {
    for (final c in _factorControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final normalized = FixedInsulinSchedule.normalize(widget.insulinFactors);

    // WICHTIG: Nur initialisieren, wenn leer. Niemals überschreiben.
    for (final id in InsulinBlockIdX.ordered) {
      final ctrl = _factorControllers[id]!;
      if (ctrl.text.isEmpty) {
        final factor = normalized.byId(id).insulinFactor;
        ctrl.text = factor.toString();
      }
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Insulin Faktoren', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),

            ...InsulinBlockIdX.ordered.map((id) {
              final f = normalized.byId(id);
              final endInclusive = FixedInsulinSchedule.displayEndInclusive(f.endTime);

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: InsulinBlockRow(
                  title: id.label,
                  showNightHint: id == InsulinBlockId.night,
                  start: f.startTime,
                  endInclusive: endInclusive,

                  // Controller kommt von außen
                  factorController: _factorControllers[id]!,

                  onPickStart: () async {
                    final picked = await show24hTimePicker(context: context, initialTime: f.startTime);
                    if (picked != null) {
                      await ref.read(userSettingsNotifierProvider.notifier).setBlockStart(id, picked);
                    }
                  },
                  onPickEnd: () async {
                    final picked = await show24hTimePicker(context: context, initialTime: endInclusive);
                    if (picked != null) {
                      await ref.read(userSettingsNotifierProvider.notifier).setBlockEnd(id, picked);
                    }
                  },

                  // Commit-only: Speichern erst wenn der Nutzer fertig ist
                  onCommitFactor: (value) async {
                    if (value == null) return;
                    await ref.read(userSettingsNotifierProvider.notifier).setBlockFactor(id, value);
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
