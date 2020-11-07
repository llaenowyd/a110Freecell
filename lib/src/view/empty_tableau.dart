import 'package:flutter/material.dart' hide Card;

import 'card.dart';

class EmptyTableau extends StatelessWidget {
  static Color _color = Colors.blue.shade100;
  final double _width;

  EmptyTableau(this._width);

  @override
  Widget build(BuildContext context) => Container(
      constraints: BoxConstraints.tight(Size(_width, Card.getHeight(_width))),
      child: Padding(
        padding: Card.padding,
        child: Opacity(
            opacity: 0.2,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  border: Border.all(color: _color, width: 4.0),
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  boxShadow: [
                    BoxShadow(
                      color: _color,
                      blurRadius: 4.0,
                    ),
                  ]),
            )),
      ));
}
