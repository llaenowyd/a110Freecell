import 'dart:math';

import 'suit.dart';
import 'rank.dart';
import 'card.dart';

class Deck {
  static final rng = Random.secure();
  static final numCards = Suit.n * Rank.n;

  static _makeInitialCards() {
    var result = List<Card>();

    Suit.values.forEach((suit) {
      Rank.values.forEach((rank) {
        result.add(Card(suit, rank));
      });
    });

    return result;
  }

  List<Card> _cards;
  int _deal;

  Deck() : _cards=_makeInitialCards(), _deal=0;

  shuffle() {
    _swap(i, j) {
      if (i != j) {
        final tmp = _cards[j];
        _cards[j] = _cards[i];
        _cards[i] = tmp;
      }
    }

    for (int i = 0; i < numCards - 1; i++) {
      int pick = rng.nextInt(numCards - i);
      _swap(i, pick+i);
    }

    _deal = 0;
  }

  Card deal() {
    return _deal == _cards.length ? null : _cards[_deal++];
  }
}
