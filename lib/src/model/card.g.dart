// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Card on _Card, Store {
  final _$_suitAtom = Atom(name: '_Card._suit');

  @override
  Suit get _suit {
    _$_suitAtom.reportRead();
    return super._suit;
  }

  @override
  set _suit(Suit value) {
    _$_suitAtom.reportWrite(value, super._suit, () {
      super._suit = value;
    });
  }

  final _$_rankAtom = Atom(name: '_Card._rank');

  @override
  Rank get _rank {
    _$_rankAtom.reportRead();
    return super._rank;
  }

  @override
  set _rank(Rank value) {
    _$_rankAtom.reportWrite(value, super._rank, () {
      super._rank = value;
    });
  }

  @override
  String toString() {
    return super.toString();
  }
}
