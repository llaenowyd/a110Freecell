import 'model.dart' as models;

class Rules {
  List<models.Tableau> _foundations;
  List<models.Freecell> _freecells;
  List<models.Tableau> _tableaux;

  Rules(this._foundations, this._freecells, this._tableaux);

  int maxMoveSize() {
    // (2^M)*(N+1)
    int calc(openTableauCount, openFreecellCount) =>
        (1 << openTableauCount) * (openFreecellCount + 1);

    return calc(
        _tableaux
            .where((tableau) => tableau != null && tableau.cards.isEmpty)
            .length,
        _freecells
            .where((freecell) => freecell != null && !freecell.hasCard)
            .length);
  }

  bool willFoundationAccept(
      models.MoveParticipant destination, models.MoveParticipant source) {
    models.Tableau destinationTableau = _foundations[destination.id];

    if (source.n != 1) return false;

    if (destinationTableau.cards.isEmpty) {
      return source.card.rank == models.Rank.ace;
    } else {
      return destination.card.suit == source.card.suit &&
          destination.card.rank.precedes(source.card.rank);
    }
  }

  bool willFreecellAccept(
      models.MoveParticipant destination, models.MoveParticipant source) {
    return !_freecells[destination.id].hasCard;
  }

  bool willTableauAccept(
      models.MoveParticipant destination, models.MoveParticipant source) {
    if (source.n > maxMoveSize()) return false;

    final destinationTableau = _tableaux[destination.id];

    if (destinationTableau.cards.isEmpty)
      return true;
    else {
      final destinationCard = destinationTableau.cards.last.card;

      return destinationCard.suit.alternates(source.card.suit) &&
          source.card.rank.precedes(destinationCard.rank);
    }
  }

  bool willAccept(
      models.MoveParticipant destination, models.MoveParticipant source) {
    if (destination.kind == models.MoveParticipantKind.foundation) {
      return willFoundationAccept(destination, source);
    } else if (destination.kind == models.MoveParticipantKind.freecell) {
      return willFreecellAccept(destination, source);
    } else if (destination.kind == models.MoveParticipantKind.tableau) {
      return willTableauAccept(destination, source);
    }
    return false;
  }
}
