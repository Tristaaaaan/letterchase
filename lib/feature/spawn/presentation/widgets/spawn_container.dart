import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letterchase/feature/spawn/presentation/provider/providers.dart';
import 'package:letterchase/feature/spawn/presentation/provider/spawn_state.dart';

class SpawnContainer extends ConsumerWidget {
  const SpawnContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spawnState = ref.watch(spawnControllerProvider);

    return spawnState.when(
      empty: () => Center(child: Text('Empty')),
      initial: () => Center(child: CircularProgressIndicator()),
      loading: () => Center(child: CircularProgressIndicator()),
      loaded:
          (spawnData) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [Text('Letter: ${spawnData?.letter ?? ""}')],
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final spawnController = ref.read(
                    spawnControllerProvider.notifier,
                  );
                  await spawnController.getSpawn();
                },
                child: Text('Spawn'),
              ),
            ],
          ),
      error: (e) => Center(child: Text(e)),
    );
  }
}
