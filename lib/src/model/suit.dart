enum SuitEnum { clubs, diamonds, hearts, spades }

class Suit {
  static final _clubs = Suit(SuitEnum.clubs);
  static final _diamonds = Suit(SuitEnum.diamonds);
  static final _hearts = Suit(SuitEnum.hearts);
  static final _spades = Suit(SuitEnum.spades);

  static final _values = [_clubs, _diamonds, _hearts, _spades];

  static get clubs => _clubs;
  static get diamonds => _diamonds;
  static get hearts => _hearts;
  static get spades => _spades;

  static get values => _values;
  static get n => _values.length;

  SuitEnum _choice;

  Suit(this._choice);

  bool alternates(Suit other) {
    return _choice == SuitEnum.clubs || _choice == SuitEnum.spades
        ? other._choice == SuitEnum.diamonds || other._choice == SuitEnum.hearts
        : other._choice == SuitEnum.clubs || other._choice == SuitEnum.spades;
  }

  @override
  String toString() => _choice == SuitEnum.hearts
      ? '♥'
      : _choice == SuitEnum.diamonds
          ? '♦'
          : _choice == SuitEnum.clubs
              ? '♣'
              : '♠';
}
