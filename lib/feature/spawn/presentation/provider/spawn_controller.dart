import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letterchase/feature/spawn/domain/spawn_repository.dart';
import 'package:letterchase/feature/spawn/presentation/provider/spawn_state.dart';

class SpawnController extends StateNotifier<SpawnState> {
  final SpawnRepository _spawnRepository;

  SpawnController(this._spawnRepository) : super(const SpawnState.initial()) {
    getSpawn();
  }

  Future<void> getSpawn({String storyId = ""}) async {
    state = const SpawnState.loading();

    try {
      final spawnData = await _spawnRepository.spawnLetter();

      if (spawnData == null) {
        state = const SpawnState.empty();
      } else {
        state = SpawnState.loaded(spawnData: spawnData);
      }
    } catch (e) {
      state = SpawnState.error(e.toString());
    }
  }

  Future<void> refreshSpawn() async {
    await getSpawn();
  }
}
