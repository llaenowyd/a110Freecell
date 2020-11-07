import 'package:flutter/material.dart' hide Card;
import 'package:flutter_mobx/flutter_mobx.dart';

import '../controller.dart';
import '../model.dart' as models;
import 'card.dart';
import 'common/card_drag_target.dart';
import 'empty_tableau.dart';

class Freecell extends StatelessWidget {
  final Controller _controller;
  final Size _size;
  final int _cellNumber;
  final models.Freecell _model;

  Freecell(this._controller, this._size, this._cellNumber, this._model);

  @override
  Widget build(BuildContext context) => Observer(builder: (_) {
        final dragChildAtRest = _model.hasCard
            ? Card(_controller, _model.cardPlacement.card, _size.width, 1.0,
                _model.cardPlacement.rotation, _cellNumber, false)
            : null;
        final dragChildInHand = dragChildAtRest == null
            ? null
            : Opacity(opacity: 0.6, child: dragChildAtRest);

        final dragParticipant = _model.hasCard
            ? models.MoveParticipant(
                kind: models.MoveParticipantKind.freecell,
                id: _cellNumber,
                card: _model.cardPlacement.card,
                n: 1)
            : models.MoveParticipant(
                kind: models.MoveParticipantKind.freecell, id: _cellNumber);

        return Container(
            constraints: BoxConstraints.tight(_size),
            child: Stack(children: [
              if (_model.hasCard) EmptyTableau(_size.width),
              _model.hasCard
                  ? GestureDetector(
                      onDoubleTap: () {
                        _controller.automove(dragParticipant);
                      },
                      child: Draggable(
                        data: dragParticipant,
                        child: dragChildAtRest,
                        feedback: dragChildInHand,
                        childWhenDragging: SizedBox.shrink(),
                      ),
                    )
                  : CardDragTarget(
                      controller: _controller,
                      child: EmptyTableau(_size.width),
                      dragParticipant: dragParticipant),
            ]));
      });
}
