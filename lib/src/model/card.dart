import 'package:mobx/mobx.dart';

import 'rank.dart';
import 'suit.dart';

part 'card.g.dart';

class Card = _Card with _$Card;

abstract class _Card with Store {
  @observable
  Suit _suit;

  @observable
  Rank _rank;

  Suit get suit => _suit;

  Rank get rank => _rank;

  _Card(this._suit, this._rank);

  @override
  String toString() => '$_suit$_rank';
}
