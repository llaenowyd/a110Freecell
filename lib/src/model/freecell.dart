import 'package:mobx/mobx.dart';

import 'card.dart';
import 'card_placement.dart';

part 'freecell.g.dart';

class Freecell = _Freecell with _$Freecell;

abstract class _Freecell with Store {
  @observable
  CardPlacement _cardPlacement;

  CardPlacement get cardPlacement => _cardPlacement;

  bool get hasCard => null != _cardPlacement;

  @override
  String toString() => 'Freecell($_cardPlacement)';

  @action
  reset() {
    if (_cardPlacement == null) return null;

    final result = _cardPlacement.card;
    _cardPlacement = null;
    return result;
  }

  @action
  set(Card newCard) {
    assert(_cardPlacement == null);
    _cardPlacement = CardPlacement(newCard);
  }
}
