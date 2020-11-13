import 'package:flutter/material.dart' hide Card;

import 'card.dart';

class EmptyTableau extends StatelessWidget {
  static Color _color = Colors.red;
  final double _width;

  EmptyTableau(this._width);

  @override
  Widget build(BuildContext context) => Container(
      constraints: BoxConstraints.tight(Size(_width, Card.getHeight(_width))),
      child: Padding(
        padding: Card.padding,
        child: Opacity(
            opacity: 0.6,
            child: Container(
                decoration: BoxDecoration(
                    color:
                        Colors.green.shade100, //Theme.of(context).canvasColor,
                    border:
                        Border.all(color: Colors.green.shade200, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.green.shade100,
                          blurRadius: 3.0,
                          offset: Offset(2, 2),
                          spreadRadius: -3.0),
                    ]),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.all(Radius.circular(4.0))),
                ))),
      ));
}
