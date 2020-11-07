import 'package:mobx/mobx.dart';

import 'card.dart';
import 'card_placement.dart';

part 'tableau.g.dart';

class Tableau = _Tableau with _$Tableau;

abstract class _Tableau with Store {
  @observable
  List<CardPlacement> _cards;

  _Tableau() : _cards = List<CardPlacement>();

  List<CardPlacement> get cards => _cards;

  @override
  String toString() => '[$_cards]';

  @action
  clear() {
    _cards = List<CardPlacement>();
  }

  @action
  remove(n) {
    final start = _cards.length - n;
    final end = _cards.length;
    final nextCards = _cards.sublist(0, start);
    final result = _cards
        .sublist(start, end)
        .map((cardRecord) => cardRecord.card)
        .toList();
    _cards = nextCards;
    return result;
  }

  @action
  add(Card newCard) {
    final nextCards = List<CardPlacement>();
    nextCards.addAll(_cards);
    nextCards.add(CardPlacement(newCard));
    _cards = nextCards;
  }

  @action
  addAll(List<Card> newCards) {
    final nextCards = List<CardPlacement>();
    nextCards.addAll(_cards);
    nextCards.addAll(newCards.map((card) => CardPlacement(card)));
    _cards = nextCards;
  }
}
