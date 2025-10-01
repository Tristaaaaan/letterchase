import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:letterchase/feature/spawn/domain/spawn_model.dart';
import 'package:letterchase/feature/spawn/domain/spawn_repository.dart';
import 'package:letterchase/feature/spawn/presentation/provider/providers.dart';
import 'package:letterchase/feature/spawn/presentation/provider/spawn_controller.dart';
import 'package:letterchase/feature/spawn/presentation/provider/spawn_state.dart';
import 'package:letterchase/feature/spawn/presentation/widgets/spawn_container.dart';

// Mock SpawnRepository for testing
class MockSpawnRepository implements SpawnRepository {
  bool calledSpawnLetter = false;
  bool calledSpawnStats = false;
  bool calledGetSpawn = false;

  @override
  Future<SpawnLetterModel?> spawnLetter() async {
    calledSpawnLetter = true;
    return SpawnLetterModel(letter: "A", rarity: "Common");
  }

  @override
  Future<List<String>> spawnStats(String rarity) async {
    calledSpawnStats = true;
    return ["+def", "+spe"];
  }

  @override
  Future<SpawnData> getSpawn() async {
    calledGetSpawn = true;
    return SpawnData(
      letter: SpawnLetterModel(letter: "A", rarity: "Common"),
      stats: ["+def", "+spe"],
    );
  }
}

void main() {
  testWidgets('SpawnContainer loads letter on init and after tapping Spawn', (
    tester,
  ) async {
    final mockRepo = MockSpawnRepository();
    late SpawnController controller;

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          spawnControllerProvider.overrideWith((ref) {
            controller = SpawnController(mockRepo);
            return controller;
          }),
        ],
        child: const MaterialApp(home: Scaffold(body: SpawnContainer())),
      ),
    );

    await tester.pumpAndSettle();

    // Verify repository call
    expect(mockRepo.calledSpawnLetter, isTrue);

    // Should show the loaded letter
    expect(find.textContaining('A'), findsOneWidget);

    // Tap "Spawn"
    await tester.tap(find.text('Spawn'));
    await tester.pumpAndSettle();

    expect(mockRepo.calledSpawnLetter, isTrue);
    expect(find.textContaining('A'), findsOneWidget);
  });
}
