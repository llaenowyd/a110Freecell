import 'package:flutter/material.dart' hide Card;
import 'package:flutter_mobx/flutter_mobx.dart';

import '../controller.dart';
import '../model.dart' as models;
import 'card.dart';
import 'foundation.dart';
import 'freecell.dart';
import 'logo.dart';
import 'tableau.dart';

class Game extends StatefulWidget {
  final models.Game _model;
  final Controller _controller;

  Game(this._model, this._controller);

  models.Game get model => _model;
  Controller get controller => _controller;

  @override
  _GameState createState() => _GameState(_model);
}

class _GameState extends State<Game> {
  final models.Game _model;

  GlobalKey _key;

  Size _size;
  double _cardWidth; // given tableaux uses full width
  double _cardHeight; // given cardWidth

  Size _freecellsSize;
  Offset _freecellsOffset;
  double _freecellSpacing;
  double _freecellCardWidth;

  Size _foundationsSize;
  Offset _foundationsOffset;
  double _foundationSpacing;
  double _foundationCardWidth;

  Size _tableauxSize;
  Offset _tableauxOffset;
  double _tableauSpacing;

  _isNotSized() => _size == null;

  _afterLayout(_) {
    final RenderBox renderBox = _key.currentContext.findRenderObject();

    setState(() {
      final verticalPadding = 5.0;

      _size = renderBox.size;
      _cardWidth = _size.width * 0.92 / 7.0;
      _cardHeight = Card.getHeight(_cardWidth);

      _freecellsSize = Size(_size.width / 2.0, _cardHeight);
      _freecellSpacing = _freecellsSize.width * 0.08 / 5.0;
      _freecellsOffset = Offset(_freecellSpacing, verticalPadding);
      _freecellCardWidth = _freecellsSize.width * 0.92 / 4.0;

      _foundationsSize = _freecellsSize;
      _foundationSpacing = _foundationsSize.width * 0.05 / 5.0;
      _foundationsOffset =
          Offset(_freecellsSize.width + _foundationSpacing, verticalPadding);
      _foundationCardWidth = _foundationsSize.width * 0.95 / 4.0;

      _tableauxOffset = Offset(
          0.0, _freecellsOffset.dy + _freecellsSize.height + verticalPadding);
      _tableauxSize = Size(_size.width,
          _size.height - _freecellsSize.height - 2.0 * verticalPadding);
      _tableauSpacing = _tableauxSize.width * 0.09 / 8.0;
    });

    _model.deal();
  }

  _GameState(this._model);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  _makeFreecells(models.Game model, Controller controller) {
    final Game gameWidget = context.widget;
    final model = gameWidget.model;
    final controller = gameWidget.controller;

    List<models.Freecell> freecellsModel = [
      model.freecell1,
      model.freecell2,
      model.freecell3,
      model.freecell4,
    ];

    final result = List<Widget>();

    for (var i = 0; i < freecellsModel.length; i++) {
      var y = _freecellsOffset.dy;
      result.add(Positioned(
          left: _freecellsOffset.dx + i * _freecellCardWidth,
          top: y,
          child: Freecell(controller, Size(_cardWidth, _cardHeight), i + 1,
              freecellsModel[i])));
    }

    return result;
  }

  _makeFoundations(models.Game model, Controller controller) {
    final Game gameWidget = context.widget;
    final model = gameWidget.model;
    final controller = gameWidget.controller;

    List<models.Tableau> foundationsModel = [
      model.foundation1,
      model.foundation2,
      model.foundation3,
      model.foundation4,
    ];

    final List<Widget> result = List<Widget>();

    for (var i = 0; i < foundationsModel.length; i++) {
      result.add(Positioned(
          left: _foundationsOffset.dx + i * _foundationCardWidth,
          top: _foundationsOffset.dy,
          child: Foundation(controller, Size(_cardWidth, _cardHeight), i + 1,
              foundationsModel[i])));
    }

    return result;
  }

  _makeTableaux(models.Game model, Controller controller) {
    List<models.Tableau> tableauxModel = [
      model.tableau1,
      model.tableau2,
      model.tableau3,
      model.tableau4,
      model.tableau5,
      model.tableau6,
      model.tableau7
    ];

    final result = List<Widget>();

    for (var i = 0; i < tableauxModel.length; i++) {
      var y = _tableauxOffset.dy;
      result.add(Positioned(
          left: _tableauSpacing + i * (_cardWidth + _tableauSpacing),
          top: y,
          child: Tableau(controller, Size(_cardWidth, _tableauxSize.height),
              i + 1, tableauxModel[i])));
    }

    return result;
  }

  Widget _makeLogo() {
    if (_isNotSized()) {
      return SizedBox.shrink();
    }

    return Logo(_size);
  }

  @override
  Widget build(BuildContext context) {
    final Game gameWidget = context.widget;
    final model = gameWidget.model;
    final controller = gameWidget.controller;

    _key = GlobalKey();

    final result = Observer(
      builder: (_) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Stack(
            key: _key,
            children: _isNotSized()
                ? []
                : model.mode == 'logo'
                    ? [_makeLogo()]
                    : [
                        ..._makeFreecells(model, controller),
                        ..._makeFoundations(model, controller),
                        ..._makeTableaux(model, controller),
                      ]),
      ),
    );

    return result;
  }
}
