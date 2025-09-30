import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:letterchase/feature/spawn/data/spawn_repo_impl.dart';
import 'package:letterchase/feature/spawn/domain/spawn_repository.dart';
import 'package:letterchase/feature/spawn/presentation/provider/spawn_controller.dart';
import 'package:letterchase/feature/spawn/presentation/provider/spawn_state.dart';

final spawnRepositoryProvider = Provider<SpawnRepository>(
  (ref) => SpawnRepoImpl(),
);

// Controller

final spawnControllerProvider =
    StateNotifierProvider<SpawnController, SpawnState>(
      (ref) => SpawnController(ref.watch(spawnRepositoryProvider)),
    );
