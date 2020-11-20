import 'package:flutter/material.dart' hide Card;

import '../model.dart' as models;

enum CardStyleEnum {
  empty,
  inPlayAnchor,
  inPlayInMotion,
  normal,
  open,
  small,
}

class CardStyle {
  Color Function(models.Card) getColor;
  Color Function(models.Card) getBackgroundColor;
  Size Function() getSuitBox;
  double Function() getFontSize;
  double Function() getBorderRadius;

  CardStyle(CardStyleEnum style) {
    final basicSuitBox = Size(10.0, 10.0);
    if (style == CardStyleEnum.normal) {
      getColor = (cardModel) => cardModel.suit == models.Suit.hearts ||
              cardModel.suit == models.Suit.diamonds
          ? Colors.red.shade900
          : Colors.black;
      getSuitBox = () => basicSuitBox;
      getBackgroundColor = (_) => Colors.lime.shade50;
      getFontSize = () => 15.0;
      getBorderRadius = () => 4.0;
    } else if (style == CardStyleEnum.inPlayAnchor) {
      getColor = (_) => Colors.cyan;
      getBackgroundColor = (_) => Colors.cyan.shade50;
      getSuitBox = () => basicSuitBox;
      getFontSize = () => 15.0;
      getBorderRadius = () => 4.0;
    } else if (style == CardStyleEnum.inPlayInMotion) {
      getColor = (_) => Colors.purple;
      getBackgroundColor = (_) => Colors.cyan.shade50.withOpacity(0.6);
      getSuitBox = () => basicSuitBox;
      getFontSize = () => 15.0;
      getBorderRadius = () => 4.0;
    } else if (style == CardStyleEnum.small) {
      getColor = (cardModel) => Colors.blue;
      getBackgroundColor = (_) => Colors.lime.shade50;
      getSuitBox = () => Size(5.0, 5.0);
      getFontSize = () => 8.0;
      getBorderRadius = () => 2.0;
    } else {
      // CardFaceStyleEnum.open
      getColor = (_) => Colors.pink;
      getBackgroundColor = (_) => Colors.lime.shade50;
      getSuitBox = () => basicSuitBox;
      getFontSize = () => 15.0;
      getBorderRadius = () => 4.0;
    }
  }
}
