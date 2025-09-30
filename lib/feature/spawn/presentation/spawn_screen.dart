import 'package:flutter/material.dart';
import 'package:letterchase/feature/spawn/presentation/widgets/spawn_container.dart';

class SpawnScreen extends StatelessWidget {
  const SpawnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(hasScrollBody: false, child: SpawnContainer()),
        ],
      ),
    );
  }
}

// SIMULATE

// final repo = SpawnRepoImpl();
//                   int attempts = 0;
//                   SpawnLetterModel? finalLetter;
//                   List<String> finalStats = [];

//                   // Keep spawning until a Rare letter with 3 stats appears
//                   while (true) {
//                     attempts++;

//                     // Spawn a letter
//                     final SpawnLetterModel? temp = await repo.spawnLetter();

//                     if (temp == null) {
//                       developer.log("Attempt $attempts → Spawned: Nothing!");
//                       continue; // skip null spawns
//                     }

//                     // Only care about Rare letters
//                     if (temp.rarity != "Rare") {
//                       developer.log(
//                         "Attempt $attempts → Spawned: $temp | Not Rare",
//                       );
//                       continue;
//                     }

//                     // Spawn stats for the Rare letter
//                     final stats = await repo.spawnStats(temp.rarity);

//                     developer.log(
//                       "Attempt $attempts → Spawned Rare: $temp | Stats: ${stats.isEmpty ? 'None' : stats.join(', ')}",
//                     );

//                     // Check if it has exactly 3 stats
//                     if (stats.length == 3) {
//                       finalLetter = temp;
//                       finalStats = stats;
//                       break; // stop loop
//                     }
//                   }

//                   // Final result
//                   developer.log(
//                     "🎉 Got a Rare letter with 3 stats after $attempts attempts → Letter: ${finalLetter.letter} | Stats: ${finalStats.join(', ')}",
//                   );
