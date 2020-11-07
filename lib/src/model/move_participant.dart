import 'package:meta/meta.dart';

import '../model.dart' as models;

enum MoveParticipantKind { tableau, foundation, freecell }

class MoveParticipant {
  MoveParticipantKind kind;
  int id;
  models.Card card;
  int n;

  MoveParticipant({@required this.kind, @required this.id, this.card, this.n});

  @override
  String toString() => 'MoveParticipant($kind, $id, $card, $n)';
}
