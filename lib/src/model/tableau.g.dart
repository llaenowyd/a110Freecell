// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tableau.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Tableau on _Tableau, Store {
  final _$_cardsAtom = Atom(name: '_Tableau._cards');

  @override
  List<CardPlacement> get _cards {
    _$_cardsAtom.reportRead();
    return super._cards;
  }

  @override
  set _cards(List<CardPlacement> value) {
    _$_cardsAtom.reportWrite(value, super._cards, () {
      super._cards = value;
    });
  }

  final _$_TableauActionController = ActionController(name: '_Tableau');

  @override
  dynamic clear() {
    final _$actionInfo =
        _$_TableauActionController.startAction(name: '_Tableau.clear');
    try {
      return super.clear();
    } finally {
      _$_TableauActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic remove(dynamic n) {
    final _$actionInfo =
        _$_TableauActionController.startAction(name: '_Tableau.remove');
    try {
      return super.remove(n);
    } finally {
      _$_TableauActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic add(Card newCard) {
    final _$actionInfo =
        _$_TableauActionController.startAction(name: '_Tableau.add');
    try {
      return super.add(newCard);
    } finally {
      _$_TableauActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addAll(List<Card> newCards) {
    final _$actionInfo =
        _$_TableauActionController.startAction(name: '_Tableau.addAll');
    try {
      return super.addAll(newCards);
    } finally {
      _$_TableauActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
