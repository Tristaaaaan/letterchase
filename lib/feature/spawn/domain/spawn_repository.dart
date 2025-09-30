import 'package:letterchase/feature/spawn/domain/spawn_model.dart';
import 'package:letterchase/feature/spawn/presentation/provider/spawn_state.dart';

abstract class SpawnRepository {
  Future<SpawnLetterModel?> spawnLetter();
  Future<List<String>> spawnStats(String rarity);
  Future<SpawnData> getSpawn();
}
