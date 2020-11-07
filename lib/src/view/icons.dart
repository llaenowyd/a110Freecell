import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract class Icon extends StatelessWidget {
  final Color color;

  String _getAssetName();

  Icon({ Key key, Color color }) : color=color, super(key: key);

  @override
  Widget build(BuildContext context) =>
    SvgPicture.asset(
      _getAssetName(),
      color: color
    );
}

class Clubs extends Icon {
  String _getAssetName() => 'lib/src/view/svg/clubs.svg';

  Clubs({ Key key, Color color }) : super(key: key, color: color);
}

class Diamonds extends Icon {
  String _getAssetName() => 'lib/src/view/svg/diamonds.svg';

  Diamonds({ Key key, Color color }) : super(key: key, color: color);
}

class Hearts extends Icon {
  String _getAssetName() => 'lib/src/view/svg/hearts.svg';

  Hearts({ Key key, Color color }) : super(key: key, color: color);
}

class Spades extends Icon {
  String _getAssetName() => 'lib/src/view/svg/spades.svg';

  Spades({ Key key, Color color }) : super(key: key, color: color);
}
