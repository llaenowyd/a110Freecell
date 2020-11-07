import 'model.dart' as models;
import 'rules.dart';

class Controller {
  models.Game _model;
  List<models.Tableau> _foundations;
  List<models.Freecell> _freecells;
  List<models.Tableau> _tableaux;
  Rules _rules;

  Controller(model)
      : _model = model,
        _foundations = [
          null,
          model.foundation1,
          model.foundation2,
          model.foundation3,
          model.foundation4,
        ],
        _freecells = [
          null,
          model.freecell1,
          model.freecell2,
          model.freecell3,
          model.freecell4,
        ],
        _tableaux = [
          null,
          model.tableau1,
          model.tableau2,
          model.tableau3,
          model.tableau4,
          model.tableau5,
          model.tableau6,
          model.tableau7,
        ] {
    _rules = Rules(_foundations, _freecells, _tableaux);
  }

  Rules get rules => _rules;

  void deal() {
    _model.deal();
  }

  int moveCardsFromTableau(
      models.MoveParticipant destination, models.MoveParticipant source) {
    if (destination.kind == models.MoveParticipantKind.tableau) {
      _tableaux[destination.id].addAll(_tableaux[source.id].remove(source.n));

      return source.n;
    } else if (destination.kind == models.MoveParticipantKind.freecell) {
      if (!_freecells[destination.id].hasCard) {
        _freecells[destination.id].set(_tableaux[source.id].remove(1).first);

        return 1;
      }
    } else if (destination.kind == models.MoveParticipantKind.foundation) {
      _foundations[destination.id].add(_tableaux[source.id].remove(1).first);

      return 1;
    }

    return 0;
  }

  int moveCardsFromFreecell(
      models.MoveParticipant destination, models.MoveParticipant source) {
    if (destination.kind == models.MoveParticipantKind.tableau) {
      _tableaux[destination.id].add(_freecells[source.id].reset());

      return 1;
    } else if (destination.kind == models.MoveParticipantKind.freecell) {
      if (!_freecells[destination.id].hasCard) {
        _freecells[destination.id].set(_freecells[source.id].reset());

        return 1;
      }
    } else if (destination.kind == models.MoveParticipantKind.foundation) {
      _foundations[destination.id].add(_freecells[source.id].reset());

      return 1;
    }

    return 0;
  }

  int moveCardsFromFoundation(
      models.MoveParticipant destination, models.MoveParticipant source) {
    if (destination.kind == models.MoveParticipantKind.tableau) {
      _tableaux[destination.id].add(_foundations[source.id].remove(1).first);

      return 1;
    } else if (destination.kind == models.MoveParticipantKind.freecell) {
      if (!_freecells[destination.id].hasCard) {
        _freecells[destination.id].set(_foundations[source.id].remove(1).first);

        return 1;
      }
    } else if (destination.kind == models.MoveParticipantKind.foundation) {
      _foundations[destination.id].add(_foundations[source.id].remove(1).first);

      return 1;
    }

    return 0;
  }

  int moveCards(
      models.MoveParticipant destination, models.MoveParticipant source) {
    if (source.kind == models.MoveParticipantKind.tableau) {
      return moveCardsFromTableau(destination, source);
    } else if (source.kind == models.MoveParticipantKind.freecell) {
      return moveCardsFromFreecell(destination, source);
    } else if (source.kind == models.MoveParticipantKind.foundation) {
      return moveCardsFromFoundation(destination, source);
    }
    return 0;
  }

  void moveCardsAndRecordMove(
      models.MoveParticipant destination, models.MoveParticipant source) {
    int movedCardCount = moveCards(destination, source);

    if (movedCardCount > 0) {
      _model.addMove(models.Move(destination.kind, destination.id, source.kind,
          source.id, movedCardCount));
    }
  }

  void automoveFromTableau(models.MoveParticipant participant) {
    if (participant.n != 1) {
      return; // tbd sub-stack moving
    }

    // check for accepting foundation
    for (var foundationId = 1; foundationId < 5; foundationId++) {
      final maybeTopCard = _foundations[foundationId].cards.isEmpty
          ? null
          : _foundations[foundationId].cards.last.card;

      final foundationPart = models.MoveParticipant(
          kind: models.MoveParticipantKind.foundation,
          id: foundationId,
          card: maybeTopCard);

      if (_rules.willFoundationAccept(foundationPart, participant)) {
        int movedCardCount = moveCardsFromTableau(foundationPart, participant);

        if (movedCardCount > 0) {
          _model.addMove(models.Move(foundationPart.kind, foundationPart.id,
              participant.kind, participant.id, movedCardCount));
        }

        return;
      }
    }

    // check for accepting tableau
    for (var tableauId = 1; tableauId < 8; tableauId++) {
      if (tableauId == participant.id) continue;

      if (_tableaux[tableauId].cards.isEmpty) continue;

      final topCard = _tableaux[tableauId].cards.last.card;

      final tableauPart = models.MoveParticipant(
          kind: models.MoveParticipantKind.tableau,
          id: tableauId,
          card: topCard);

      if (_rules.willTableauAccept(tableauPart, participant)) {
        int movedCardCount = moveCardsFromTableau(tableauPart, participant);

        if (movedCardCount > 0) {
          _model.addMove(models.Move(tableauPart.kind, tableauPart.id,
              participant.kind, participant.id, movedCardCount));
        }

        return;
      }
    }

    // check for empty freecell
    for (var freecellId = 1; freecellId < 5; freecellId++) {
      final freecellPart = models.MoveParticipant(
          kind: models.MoveParticipantKind.freecell, id: freecellId);

      if (_rules.willFreecellAccept(freecellPart, participant)) {
        int movedCardCount = moveCardsFromTableau(freecellPart, participant);

        if (movedCardCount > 0) {
          _model.addMove(models.Move(freecellPart.kind, freecellPart.id,
              participant.kind, participant.id, movedCardCount));
        }

        return;
      }
    }

    // check for empty tableau
    for (var tableauId = 1; tableauId < 8; tableauId++) {
      if (tableauId == participant.id) continue;

      if (_tableaux[tableauId].cards.isNotEmpty) continue;

      final tableauPart = models.MoveParticipant(
          kind: models.MoveParticipantKind.tableau, id: tableauId);

      if (_rules.willTableauAccept(tableauPart, participant)) {
        int movedCardCount = moveCardsFromTableau(tableauPart, participant);

        if (movedCardCount > 0) {
          _model.addMove(models.Move(tableauPart.kind, tableauPart.id,
              participant.kind, participant.id, movedCardCount));
        }

        return;
      }
    }
  }

  void automoveFromFreecell(models.MoveParticipant participant) {
    // check for accepting foundation
    for (var foundationId = 1; foundationId < 5; foundationId++) {
      final maybeTopCard = _foundations[foundationId].cards.isEmpty
          ? null
          : _foundations[foundationId].cards.last.card;

      final foundationPart = models.MoveParticipant(
          kind: models.MoveParticipantKind.foundation,
          id: foundationId,
          card: maybeTopCard);

      if (_rules.willFoundationAccept(foundationPart, participant)) {
        int movedCardCount = moveCardsFromFreecell(foundationPart, participant);

        if (movedCardCount > 0) {
          _model.addMove(models.Move(foundationPart.kind, foundationPart.id,
              participant.kind, participant.id, movedCardCount));
        }

        return;
      }
    }

    // check for accepting tableau
    for (var tableauId = 1; tableauId < 8; tableauId++) {
      if (_tableaux[tableauId].cards.isEmpty) continue;

      final topCard = _tableaux[tableauId].cards.last.card;

      final tableauPart = models.MoveParticipant(
          kind: models.MoveParticipantKind.tableau,
          id: tableauId,
          card: topCard);

      if (_rules.willTableauAccept(tableauPart, participant)) {
        int movedCardCount = moveCardsFromFreecell(tableauPart, participant);

        if (movedCardCount > 0) {
          _model.addMove(models.Move(tableauPart.kind, tableauPart.id,
              participant.kind, participant.id, movedCardCount));
        }

        return;
      }
    }

    // check for empty tableau
    for (var tableauId = 1; tableauId < 8; tableauId++) {
      if (_tableaux[tableauId].cards.isNotEmpty) continue;

      final tableauPart = models.MoveParticipant(
          kind: models.MoveParticipantKind.tableau, id: tableauId);

      if (_rules.willTableauAccept(tableauPart, participant)) {
        int movedCardCount = moveCardsFromFreecell(tableauPart, participant);

        if (movedCardCount > 0) {
          _model.addMove(models.Move(tableauPart.kind, tableauPart.id,
              participant.kind, participant.id, movedCardCount));
        }

        return;
      }
    }
  }

  void automove(models.MoveParticipant participant) {
    if (participant.kind == models.MoveParticipantKind.tableau) {
      automoveFromTableau(participant);
    } else if (participant.kind == models.MoveParticipantKind.freecell) {
      automoveFromFreecell(participant);
    }
  }

  void undo() {
    final move = _model.getLatestMove();

    if (move == null) return;

    final previousDestination = models.MoveParticipant(
        kind: move.destinationKind, id: move.destinationId);

    final previousSource =
        models.MoveParticipant(kind: move.sourceKind, id: move.sourceId);

    final movedCards =
        move.destinationKind == models.MoveParticipantKind.tableau
            ? _tableaux[move.destinationId].remove(move.n)
            : move.destinationKind == models.MoveParticipantKind.freecell
                ? (() {
                    final result = List<models.Card>();
                    result.add(_freecells[move.destinationId].reset());
                    return result;
                  })()
                : move.destinationKind == models.MoveParticipantKind.foundation
                    ? _foundations[move.destinationId].remove(move.n)
                    : [];

    if (movedCards.length < 1) return;

    if (move.sourceKind == models.MoveParticipantKind.tableau) {
      _tableaux[move.sourceId].addAll(movedCards);
    } else if (move.sourceKind == models.MoveParticipantKind.freecell) {
      _freecells[move.sourceId].set(movedCards.first);
    } else if (move.sourceKind == models.MoveParticipantKind.foundation) {
      _foundations[move.sourceId].addAll(movedCards);
    }
  }
}
