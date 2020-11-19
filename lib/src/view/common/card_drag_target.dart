import 'package:flutter/material.dart';

import '../../controller.dart';
import '../../model.dart' as models;

class CardDragTarget extends StatelessWidget {
  final Controller controller;
  final Widget child;
  final models.MoveParticipant dragParticipant;

  CardDragTarget(
      {@required this.controller,
      @required this.child,
      @required this.dragParticipant});

  @override
  Widget build(BuildContext context) => DragTarget<models.MoveParticipant>(
      builder: (_a, _b, _c) => child,
      onWillAccept: (otherDragParticipant) {
        if (dragParticipant.kind == otherDragParticipant.kind &&
            dragParticipant.id == otherDragParticipant.id) return false;

        print('onWillAccept $dragParticipant $otherDragParticipant');
        return controller.rules
            .willAccept(dragParticipant, otherDragParticipant);
      },
      onAccept: (otherDragParticipant) {
        controller.moveCardsAndRecordMove(
            dragParticipant, otherDragParticipant);
      });
}
