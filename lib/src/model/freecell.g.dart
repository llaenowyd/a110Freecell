// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freecell.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Freecell on _Freecell, Store {
  final _$_cardPlacementAtom = Atom(name: '_Freecell._cardPlacement');

  @override
  CardPlacement get _cardPlacement {
    _$_cardPlacementAtom.reportRead();
    return super._cardPlacement;
  }

  @override
  set _cardPlacement(CardPlacement value) {
    _$_cardPlacementAtom.reportWrite(value, super._cardPlacement, () {
      super._cardPlacement = value;
    });
  }

  final _$_FreecellActionController = ActionController(name: '_Freecell');

  @override
  dynamic reset() {
    final _$actionInfo =
        _$_FreecellActionController.startAction(name: '_Freecell.reset');
    try {
      return super.reset();
    } finally {
      _$_FreecellActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic set(Card newCard) {
    final _$actionInfo =
        _$_FreecellActionController.startAction(name: '_Freecell.set');
    try {
      return super.set(newCard);
    } finally {
      _$_FreecellActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
