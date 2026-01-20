import 'package:easy_carbs/presentation/screens/insulin_factor_edit/widgets/insulin_blocks_card.dart';
import 'package:easy_carbs/presentation/state/user_settings/user_settings_async_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InsulinFactorsEditScreen extends ConsumerWidget {
  const InsulinFactorsEditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(userSettingsNotifierProvider);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Insulin-Faktoren bearbeiten')),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: settingsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, st) => Center(child: Text('$err')),
            data: (settings) {
              return ListView(
                children: [
                  InsulinBlocksCard(insulinFactors: settings.insulinFactors),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
