import 'dart:math';

import 'package:letterchase/feature/spawn/domain/spawn_model.dart';
import 'package:letterchase/feature/spawn/domain/spawn_repository.dart';
import 'package:letterchase/feature/spawn/presentation/provider/spawn_state.dart';

class SpawnRepoImpl extends SpawnRepository {
  final _random = Random();

  // Letter pools
  static const List<String> commonLetters = ["E", "A", "I", "O", "N", "R", "T"];
  static const List<String> midLetters = ["L", "S", "U", "D", "G"];
  static const List<String> uncommonLetters = [
    "B",
    "C",
    "M",
    "P",
    "F",
    "H",
    "V",
    "W",
    "Y",
  ];
  static const List<String> rareLetters = ["K", "J", "X", "Q", "Z"];

  // Stat pool
  static const List<String> allStats = ["+def", "+spe", "+stk"];

  @override
  Future<SpawnLetterModel?> spawnLetter() async {
    // 20% chance to get nothing
    if (_random.nextInt(100) + 1 > 80) return null;

    int roll = _random.nextInt(100) + 1;
    String rarity;
    List<String> pool;

    if (roll <= 60) {
      rarity = "Common";
      pool = commonLetters;
    } else if (roll <= 85) {
      rarity = "Mid";
      pool = midLetters;
    } else if (roll <= 95) {
      rarity = "Uncommon";
      pool = uncommonLetters;
    } else {
      rarity = "Rare";
      pool = rareLetters;
    }

    String letter = pool[_random.nextInt(pool.length)];

    return SpawnLetterModel(letter: letter, rarity: rarity);
  }

  @override
  Future<List<String>> spawnStats(String rarity) async {
    List<String> stats = [];

    for (var stat in allStats) {
      int roll = _random.nextInt(100) + 1; // 1..100
      int chance = 0;

      switch (rarity) {
        case "Common":
          chance = 75;
          break;
        case "Mid":
          chance = 67;
          break;
        case "Uncommon":
          chance = 39;
          break;
        case "Rare":
          chance = 20;
          break;
      }

      if (roll <= chance) stats.add(stat);
    }

    return stats;
  }

  @override
  Future<SpawnData> getSpawn() async {
    var letter = await spawnLetter();
    var stats = await spawnStats(letter?.rarity ?? "Common");

    return SpawnData(letter: letter, stats: stats);
  }
}
