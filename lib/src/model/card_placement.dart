import 'dart:math' as math;

import 'card.dart';

class CardPlacement {
  static final rng = math.Random.secure();
  static getRandomRotation() => rng.nextDouble() * 0.06981 - 0.03491;

  final Card _card;
  final double _rotation;

  CardPlacement(this._card) : _rotation = getRandomRotation();

  Card get card => _card;
  double get rotation => _rotation;

  @override
  String toString() => 'CardPlacement($_card, $_rotation)';
}
