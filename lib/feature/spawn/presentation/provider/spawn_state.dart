import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:letterchase/feature/spawn/domain/spawn_model.dart';

part 'spawn_state.freezed.dart';

@freezed
class SpawnState with _$SpawnState {
  const factory SpawnState.initial() = _Initial;
  const factory SpawnState.loading() = _Loading;
  const factory SpawnState.loaded({SpawnLetterModel? spawnData}) = _Loaded;
  const factory SpawnState.error(String message) = _Error;
  const factory SpawnState.empty() = _Empty;
}

class SpawnData {
  final SpawnLetterModel? letter;
  final List<String>? stats;

  SpawnData({this.letter, this.stats});
}
