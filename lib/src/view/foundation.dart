import 'package:flutter/material.dart' hide Card;
import 'package:flutter_mobx/flutter_mobx.dart';

import '../controller.dart';
import '../model.dart' as models;
import 'card.dart';
import 'common/card_drag_target.dart';
import 'empty_tableau.dart';

class Foundation extends StatelessWidget {
  final Controller _controller;
  final Size _size;
  final int _foundationNumber;
  final models.Tableau _model;

  Foundation(this._controller, this._size, this._foundationNumber, this._model);

  Widget _makeStack() {
    // final elevator = Iterable<double>.generate(
    //     int count,
    //     (x) => double(x + 1)
    // );

    Iterable<double> elevator() sync* {
      double elevation = 0.0;
      while (true) {
        elevation += 1.0;
        yield elevation;
      }
    }

    // Iterable<int> naturalsTo(int n) sync* {
    // int k = 0;
    // while (k < n) yield k++;
    // }

    final makeCard = (cardPlacement) => cardPlacement == null
        ? null
        : Card(
            _controller,
            cardPlacement.card,
            _size.width,
            elevator().take(1).first,
            cardPlacement.rotation,
            _foundationNumber,
            false);

    // final tableauHeight = _size.height;
    // final cardHeight = Card.getHeight(_size.width);
    final List<Widget> stackBelow = _model.cards.isEmpty
        ? []
        : _model.cards
            .sublist(0, _model.cards.length - 1)
            .map(makeCard)
            .toList();

    final models.CardPlacement topModel =
        _model.cards.isEmpty ? null : _model.cards.last;

    final Widget top = makeCard(topModel);

    final dragChildAtRest = top == null
        ? null
        : Container(
            constraints: BoxConstraints.tight(_size),
            child: top,
          );

    final dragChildInHand = dragChildAtRest == null
        ? null
        : Opacity(opacity: 0.6, child: dragChildAtRest);

    final maybeDraggable = dragChildInHand == null
        ? null
        : Draggable(
            data: models.MoveParticipant(
                kind: models.MoveParticipantKind.foundation,
                id: _foundationNumber,
                card: topModel.card,
                n: 1),
            child: dragChildAtRest,
            feedback: dragChildInHand,
            childWhenDragging: SizedBox.shrink(),
          );

    final List<Widget> children = [EmptyTableau(_size.width)];

    if (stackBelow.isNotEmpty) children.addAll(stackBelow);
    if (null != maybeDraggable) children.add(maybeDraggable);

    return Stack(children: children);
  }

  @override
  Widget build(BuildContext context) => Observer(
      builder: (_) => CardDragTarget(
          controller: _controller,
          dragParticipant: models.MoveParticipant(
              kind: models.MoveParticipantKind.foundation,
              id: _foundationNumber,
              card: _model.cards.isEmpty ? null : _model.cards.last.card),
          child: Container(
            constraints: BoxConstraints.tight(_size),
            child: _makeStack(),
          )));
}
