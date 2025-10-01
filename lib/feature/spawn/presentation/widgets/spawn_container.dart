import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letterchase/common/components/button/loading_state_notifier.dart';
import 'package:letterchase/common/components/button/regular_button.dart';
import 'package:letterchase/feature/spawn/presentation/provider/providers.dart';
import 'package:letterchase/feature/spawn/presentation/provider/spawn_state.dart';

class SpawnContainer extends ConsumerWidget {
  const SpawnContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spawnState = ref.watch(spawnControllerProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: spawnState.when(
              empty: () => const Text('Nothing'),
              initial: () => const CircularProgressIndicator(),
              loading: () => const CircularProgressIndicator(),
              loaded: (spawnData) => Text('Letter: ${spawnData?.letter ?? ""}'),
              error: (e) => Text(e),
            ),
          ),
        ),
        const SizedBox(height: 16),

        RegularButton(
          text: "Spawn",
          backgroundColor: Colors.green,
          textColor: Colors.white,
          buttonKey: "spawnButton",
          width: double.infinity,
          onTap: () async {
            final isLoading = ref.read(regularButtonLoadingProvider.notifier);

            isLoading.setLoading("spawnButton", true);

            developer.log("Spawn button pressed");

            final spawnController = ref.read(spawnControllerProvider.notifier);
            await spawnController.getSpawn();
            isLoading.setLoading("spawnButton", false);
          },
        ),
      ],
    );
  }
}
