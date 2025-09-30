class SpawnLetterModel {
  final String letter;
  final String rarity;

  SpawnLetterModel({required this.letter, required this.rarity});

  @override
  String toString() => "Letter: $letter | Rarity: $rarity";
}
