import 'package:flutter/material.dart' hide Card;
import 'package:flutter/material.dart' as material show Card;
import 'package:google_fonts/google_fonts.dart';

import '../controller.dart';
import '../model.dart' as models;
import 'card_style.dart';
import 'icons.dart';

class Card extends StatelessWidget {
  static getHeight(w) => 1.4 * w;
  static final padding = EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0);

  final Controller _controller;
  final models.Card _model;
  final double _width;
  final double _elevation;
  final double _rotation;
  final int _tableauNumber;
  final bool _isDragTarget;
  final CardStyleEnum _style;
  final Color _backgroundColor;
  final Color _color;

  _makeClubs(faceStyle, color) => SizedBox(
      width: faceStyle.getSuitBox().width,
      height: faceStyle.getSuitBox().height,
      child: Clubs(color: color));
  _makeDiamonds(faceStyle, color) => SizedBox(
      width: faceStyle.getSuitBox().width,
      height: faceStyle.getSuitBox().height,
      child: Diamonds(color: color));
  _makeHearts(faceStyle, color) => Padding(
        padding: EdgeInsets.only(left: 1.0),
        child: SizedBox(
          width: faceStyle.getSuitBox().width * 0.9,
          height: faceStyle.getSuitBox().height,
          child: Hearts(color: color),
        ),
      );
  _makeSpades(faceStyle, color) => SizedBox(
      width: faceStyle.getSuitBox().width,
      height: faceStyle.getSuitBox().height,
      child: Spades(color: color));

  Card(this._controller, this._model, this._width, this._elevation,
      this._rotation, this._tableauNumber, this._isDragTarget,
      [CardStyleEnum style, Color backgroundColor, Color color])
      : _style = style == null ? CardStyleEnum.normal : style,
        _backgroundColor = backgroundColor,
        _color = color;

  @override
  Widget build(BuildContext context) {
    final faceStyle = CardStyle(_style);
    final backgroundColor = _backgroundColor == null
        ? faceStyle.getBackgroundColor(_model)
        : _backgroundColor;
    final color = _color == null ? faceStyle.getColor(_model) : _color;
    final cardSize = Size(_width, getHeight(_width));

    final materialCard = Container(
      constraints: BoxConstraints.tight(cardSize),
      child: material.Card(
        borderOnForeground: true,
        elevation: _elevation,
        color: backgroundColor,
        child: MediaQuery(
          // tbd remove duplicate?
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Container(
              foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(faceStyle.getBorderRadius())),
                  border: Border(
                    top: BorderSide(width: 0.5, color: Color(0xFFE6EE9C)),
                    left: BorderSide(width: 0.5, color: Color(0xFFE6EE9C)),
                    right: BorderSide(width: 0.5, color: Color(0xFFE6EE9C)),
                    bottom: BorderSide(width: 0.5, color: Color(0xFFE6EE9C)),
                  )),
              child: Column(children: [
                Padding(
                    padding: padding,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _model.rank.toString(),
                            style: GoogleFonts.getFont('Unica One',
                                textStyle: TextStyle(
                                  color: color,
                                  fontSize: faceStyle.getFontSize(),
                                  letterSpacing: -2.0,
                                )),
                          ),
                          _model.suit == models.Suit.hearts
                              ? _makeHearts(faceStyle, color)
                              : _model.suit == models.Suit.clubs
                                  ? _makeClubs(faceStyle, color)
                                  : _model.suit == models.Suit.diamonds
                                      ? _makeDiamonds(faceStyle, color)
                                      : _makeSpades(faceStyle, color),
                        ]))
              ])),
        ),
      ),
    );

    final dragParticipant = _isDragTarget
        ? models.MoveParticipant(
            kind: models.MoveParticipantKind.tableau,
            id: _tableauNumber,
            card: _model)
        : null;

    final maybeDragTarget = _isDragTarget
        ? DragTarget<models.MoveParticipant>(
            builder: (_a, _b, _c) => materialCard,
            onWillAccept: (otherDragParticipant) {
              print('onWillAccept $dragParticipant $otherDragParticipant');
              return _controller.rules
                  .willAccept(dragParticipant, otherDragParticipant);
            },
            onAccept: (otherDragParticipant) {
              _controller.moveCardsAndRecordMove(
                  dragParticipant, otherDragParticipant);
            })
        : materialCard;

    return Transform(
      transform: Matrix4.rotationZ(_rotation),
      child: maybeDragTarget,
    );
  }
}
