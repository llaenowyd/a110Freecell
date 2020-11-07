import 'dart:math' as math;

import 'package:flutter/material.dart' hide Card;

import '../model.dart' as models;
import 'card.dart';
import 'card_style.dart';

class Logo extends StatelessWidget {
  final Size _size;

  _makeLine(double x1, double y1, double x2, double y2, int count,
      double rotation, double elevation, style, backgroundColor, color) {
    final offsets = List<Offset>();

    for (var i = 0; i < count; i++) {
      offsets.add(
          Offset(x1 + i * (x2 - x1) / count, (y1 + i * (y2 - y1) / count)));
    }

    return offsets
        .map((offset) => Positioned(
            left: offset.dx,
            top: offset.dy,
            child: Card(
                null,
                models.Card(models.Suit.hearts, models.Rank.ace),
                28.0,
                elevation,
                rotation,
                1,
                false,
                CardStyleEnum.small,
                backgroundColor,
                color)))
        .toList();
  }

  _makeTopBar() {
    final cardsPerLayer = 25;
    final frontDxPerLayer = 6;
    final backDxPerLayer = 10;
    final dyPerLayer = 6;
    final dCountPerLayer = 2;
    final layerCount = 5;

    final baseX1 = 5.0;
    final baseY1 = _size.height / 2.0 - 80.0;
    final baseX2 = _size.width / 2.0;
    final baseY2 = 15.0;

    final result = List<Widget>();

    for (var i = 0; i < layerCount; i++) {
      result.addAll(_makeLine(
          baseX1 + i * frontDxPerLayer,
          baseY1 + i * dyPerLayer,
          baseX2 + i * backDxPerLayer,
          baseY2,
          cardsPerLayer + i * dCountPerLayer,
          -1.0 * math.pi / 4.0,
          1.0,
          CardStyleEnum.small,
          Colors.blue,
          Colors.white));
    }
    return result;
  }

  _makeDiamond() {
    final cardsPerLayer = 8;
    final frontDxPerLayer = 6;
    final backDxPerLayer = 6;
    final frontDyPerLayer = 6;
    final backDyPerLayer = 6;
    final dCountPerLayer = 0;
    final layerCount = 5;

    final baseX1 = 75.0;
    final baseY1 = _size.height / 2.0 - 12.0;
    final baseX2 = _size.width / 2.0 - 80.0;
    final baseY2 = _size.height / 2.0 - 58.0;

    final result = List<Widget>();

    for (var i = 0; i < layerCount; i++) {
      result.addAll(_makeLine(
        baseX1 + i * frontDxPerLayer,
        baseY1 + i * frontDyPerLayer,
        baseX2 + i * backDxPerLayer,
        baseY2 + i * backDyPerLayer,
        cardsPerLayer + i * dCountPerLayer,
        -1.0 * math.pi / 4.0,
        1.0,
        CardStyleEnum.small,
        Colors.blue,
        Colors.white,
      ));
    }
    return result;
  }

  List<Widget> _makeMidTrap() {
    final cardsPerLayer = 8;
    final frontDxPerLayer = 6;
    final backDxPerLayer = 9.5;
    final frontDyPerLayer = 6;
    final backDyPerLayer = 1;
    final dCountPerLayer = 3;
    final layerCount = 5;

    final baseX1 = _size.width / 2.0 - 70.0;
    final baseY1 = _size.height / 2.0 - 70.0;
    final baseX2 = _size.width / 2.0 + 10.0;
    final baseY2 = _size.height / 2.0 - 155.0;

    final result = List<Widget>();

    for (var i = 0; i < layerCount; i++) {
      result.addAll(_makeLine(
          baseX1 + i * frontDxPerLayer,
          baseY1 + i * frontDyPerLayer,
          baseX2 + i * backDxPerLayer,
          baseY2 + i * backDyPerLayer,
          cardsPerLayer + i * dCountPerLayer,
          -1.0 * math.pi / 4.0,
          1.0,
          CardStyleEnum.small,
          Colors.blue.shade200,
          Colors.white));
    }
    return result;
  }

  List<Widget> _makeStem() {
    final cardsPerLayer = 8;
    final frontDxPerLayer = 5.4;
    final backDxPerLayer = 12;
    final frontDyPerLayer = -6;
    final backDyPerLayer = -0.2;
    final dCountPerLayer = 1;
    final layerCount = 8;

    final baseX1 = _size.width / 2.0 - 75.0;
    final baseY1 = _size.height / 2.0 + 35.0;
    final baseX2 = _size.width / 2.0 - 10.0;
    final baseY2 = _size.height / 2.0 + 100.0;

    final result = List<Widget>();

    for (var i = 0; i < layerCount; i++) {
      result.addAll(_makeLine(
          baseX1 + i * frontDxPerLayer,
          baseY1 + i * frontDyPerLayer,
          baseX2 + i * backDxPerLayer,
          baseY2 + i * backDyPerLayer,
          cardsPerLayer + i * dCountPerLayer,
          -1.0 * math.pi / 4.0,
          1.0,
          CardStyleEnum.small,
          Colors.blue.shade800,
          Colors.white));
    }
    return result;
  }

  List<Widget> _makeChildren() => [
        ..._makeTopBar(),
        ..._makeDiamond(),
        ..._makeMidTrap(),
        ..._makeStem(),
        // Positioned(
        //     left: 15.0,
        //     top: _size.height / 2.0,
        //     child: Card(null, models.Card(models.Suit.hearts, models.Rank.ace),
        //         28.0, 1.0, -1.0 * math.pi / 4.0, 1, false, CardStyleEnum.small))
      ];

  Logo(this._size);

  @override
  Widget build(BuildContext context) => Stack(children: _makeChildren());
}
