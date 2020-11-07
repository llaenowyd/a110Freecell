import 'package:flutter/material.dart' hide Card;
import 'package:flutter_mobx/flutter_mobx.dart';

import '../controller.dart';
import '../model.dart' as models;
import 'card.dart';
import 'common/card_drag_target.dart';
import 'empty_tableau.dart';

class Tableau extends StatelessWidget {
  static List<List<models.CardPlacement>> aperture(
      int n, List<models.CardPlacement> list) {
    var idx = 0;
    final limit = list.length - (n - 1);
    final acc = new List<List<models.CardPlacement>>();
    while (idx < limit) {
      acc.add(list.sublist(idx, idx + n));
      idx += 1;
    }
    return acc;
  }

  static bool isCascade(List<models.CardPlacement> cards) => cards.isEmpty
      ? false
      : !aperture(2, cards).any((List<models.CardPlacement> adjacents) {
          final head = adjacents.first.card;
          final tail = adjacents.last.card;

          return !head.suit.alternates(tail.suit) ||
              !tail.rank.precedes(head.rank);
        });

  static const offsetPerCard = [20.0, 18.0, 16.0, 14.0, 12.0, 10.0, 8.0, 6.0];

  static getScrunchFit(tableauHeight, cardHeight) => (opcAtScrunch) =>
      1 + ((tableauHeight - cardHeight) / opcAtScrunch).floor();

  final Controller _controller;
  final Size _size;
  final int _tableauNumber;
  final models.Tableau _model;

  Tableau(this._controller, this._size, this._tableauNumber, this._model);

  Widget _makeDragStack() {
    final tableauHeight = _size.height;
    final cardHeight = Card.getHeight(_size.width);
    final cardCount = _model.cards.length;

    final scrunchFit = getScrunchFit(tableauHeight, cardHeight);

    final scrunchLevel = ((sl) => sl == -1 ? offsetPerCard.length - 1 : sl)(
        offsetPerCard.indexWhere(
            (opcAtScrunch) => cardCount <= scrunchFit(opcAtScrunch)));

    print(
        'scrunchLevel $scrunchLevel ($tableauHeight, $cardHeight, $cardCount)');

    final opcAtScrunch = offsetPerCard[scrunchLevel];

    Widget subroutine(Size size, double x, double y, double elevation,
        List<models.CardPlacement> tailCards) {
      final head = tailCards.first;
      final rest = tailCards.sublist(1);

      final isDraggable = isCascade(tailCards);

      final dragChildAtRest = Container(
          constraints: BoxConstraints.tight(size),
          child: Stack(children: [
            Card(_controller, head.card, size.width, elevation, head.rotation,
                _tableauNumber, rest.isEmpty),
            if (rest.isNotEmpty)
              subroutine(Size(size.width, size.height - opcAtScrunch), x,
                  opcAtScrunch, elevation += 1.0, rest)
          ]));

      final maybeDraggableChild = isDraggable
          ? Draggable(
              data: models.MoveParticipant(
                  kind: models.MoveParticipantKind.tableau,
                  id: _tableauNumber,
                  card: head.card,
                  n: tailCards.length),
              child: dragChildAtRest,
              feedback: Opacity(opacity: 0.6, child: dragChildAtRest),
              childWhenDragging: SizedBox.shrink(),
            )
          : dragChildAtRest;

      return Positioned(
          left: x,
          top: y,
          child: GestureDetector(
              onDoubleTap: () {
                if (tailCards.length == 1) {
                  print('tableau top double tap');
                  _controller.automove(models.MoveParticipant(
                      kind: models.MoveParticipantKind.tableau,
                      id: _tableauNumber,
                      card: head.card,
                      n: 1));
                } else {
                  print('tableau non top double tap');
                }
              },
              child: maybeDraggableChild));
    }

    return subroutine(_size, 0.0, 0.0, 0.0, _model.cards);
  }

  @override
  Widget build(BuildContext context) => Observer(builder: (_) {
        final hasCards = _model.cards.isNotEmpty;

        return Container(
            constraints: BoxConstraints.tight(_size),
            child: Stack(children: [
              hasCards
                  ? EmptyTableau(_size.width)
                  : CardDragTarget(
                      controller: _controller,
                      child: EmptyTableau(_size.width),
                      dragParticipant: models.MoveParticipant(
                          kind: models.MoveParticipantKind.tableau,
                          id: _tableauNumber)),
              if (hasCards) _makeDragStack(),
            ]));
      });
}
