import 'package:mobx/mobx.dart';

import 'deck.dart';
import 'freecell.dart';
import 'move.dart';
import 'tableau.dart';

part 'game.g.dart';

class Game = _Game with _$Game;

abstract class _Game with Store {
  @observable
  String _mode;

  Deck _deck;

  List<Move> _moves;

  @observable
  Tableau _tableau1;

  @observable
  Tableau _tableau2;

  @observable
  Tableau _tableau3;

  @observable
  Tableau _tableau4;

  @observable
  Tableau _tableau5;

  @observable
  Tableau _tableau6;

  @observable
  Tableau _tableau7;

  @observable
  Freecell _freecell1;

  @observable
  Freecell _freecell2;

  @observable
  Freecell _freecell3;

  @observable
  Freecell _freecell4;

  @observable
  Tableau _foundation1;

  @observable
  Tableau _foundation2;

  @observable
  Tableau _foundation3;

  @observable
  Tableau _foundation4;

  _Game()
      : _mode = 'logo',
        _deck = Deck(),
        _moves = List<Move>(),
        _tableau1 = Tableau(),
        _tableau2 = Tableau(),
        _tableau3 = Tableau(),
        _tableau4 = Tableau(),
        _tableau5 = Tableau(),
        _tableau6 = Tableau(),
        _tableau7 = Tableau(),
        _freecell1 = Freecell(),
        _freecell2 = Freecell(),
        _freecell3 = Freecell(),
        _freecell4 = Freecell(),
        _foundation1 = Tableau(),
        _foundation2 = Tableau(),
        _foundation3 = Tableau(),
        _foundation4 = Tableau();

  String get mode => _mode;
  Tableau get tableau1 => _tableau1;
  Tableau get tableau2 => _tableau2;
  Tableau get tableau3 => _tableau3;
  Tableau get tableau4 => _tableau4;
  Tableau get tableau5 => _tableau5;
  Tableau get tableau6 => _tableau6;
  Tableau get tableau7 => _tableau7;
  Freecell get freecell1 => _freecell1;
  Freecell get freecell2 => _freecell2;
  Freecell get freecell3 => _freecell3;
  Freecell get freecell4 => _freecell4;
  Tableau get foundation1 => _foundation1;
  Tableau get foundation2 => _foundation2;
  Tableau get foundation3 => _foundation3;
  Tableau get foundation4 => _foundation4;

  @action
  deal() {
    _mode = 'game';
    _deck.shuffle();

    _moves.clear();

    List<Freecell> freecells = [_freecell1, _freecell2, _freecell3, _freecell4];

    freecells.forEach((freecell) => freecell.reset());

    List<Tableau> foundations = [
      _foundation1,
      _foundation2,
      _foundation3,
      _foundation4,
    ];

    foundations.forEach((foundation) => foundation.clear());

    List<Tableau> tableaux = [
      _tableau1,
      _tableau2,
      _tableau3,
      _tableau4,
      _tableau5,
      _tableau6,
      _tableau7
    ];

    tableaux.forEach((tableau) => tableau.clear());

    int tableauIndex = 0;
    var card = _deck.deal();
    while (null != card) {
      tableaux[tableauIndex++ % 7].add(card);
      card = _deck.deal();
    }
  }

  void addMove(Move move) => _moves.add(move);

  Move getLatestMove() => _moves.isEmpty ? null : _moves.removeLast();
}
