import 'move_participant.dart';

class Move {
  final MoveParticipantKind _destinationKind;
  final int _destinationId;
  final MoveParticipantKind _sourceKind;
  final int _sourceId;
  final int _n;

  Move(this._destinationKind, this._destinationId, this._sourceKind,
      this._sourceId, this._n);

  MoveParticipantKind get destinationKind => _destinationKind;
  int get destinationId => _destinationId;
  MoveParticipantKind get sourceKind => _sourceKind;
  int get sourceId => _sourceId;
  int get n => _n;

  @override
  String toString() =>
      'Move($_destinationKind, $_destinationId, $_sourceKind, $_sourceId, $_n)';
}
