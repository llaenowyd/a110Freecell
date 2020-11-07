enum RankEnum {
  ace,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
  jack,
  queen,
  king
}

class Rank {
  static final _ace = Rank(RankEnum.ace);
  static final _two = Rank(RankEnum.two);
  static final _three = Rank(RankEnum.three);
  static final _four = Rank(RankEnum.four);
  static final _five = Rank(RankEnum.five);
  static final _six = Rank(RankEnum.six);
  static final _seven = Rank(RankEnum.seven);
  static final _eight = Rank(RankEnum.eight);
  static final _nine = Rank(RankEnum.nine);
  static final _ten = Rank(RankEnum.ten);
  static final _jack = Rank(RankEnum.jack);
  static final _queen = Rank(RankEnum.queen);
  static final _king = Rank(RankEnum.king);

  static final _values = [
    _ace,
    _two,
    _three,
    _four,
    _five,
    _six,
    _seven,
    _eight,
    _nine,
    _ten,
    _jack,
    _queen,
    _king,
  ];

  static final _precedence = (() {
    final result = Map<Rank, Rank>();
    for (var i = 0; i < _values.length - 1; i++) {
      result[_values[i]] = _values[i + 1];
    }
    return result;
  })();

  static get ace => _ace;
  static get two => _two;
  static get three => _three;
  static get four => _four;
  static get five => _five;
  static get six => _six;
  static get seven => _seven;
  static get eight => _eight;
  static get nine => _nine;
  static get ten => _ten;
  static get jack => _jack;
  static get queen => _queen;
  static get king => _king;

  static get values => _values;
  static get n => _values.length;

  RankEnum _choice;

  Rank(this._choice);

  bool precedes(Rank other) {
    return _choice != RankEnum.king && _precedence[this] == other;
  }

  @override
  String toString() => _choice == RankEnum.ace
      ? 'A'
      : _choice == RankEnum.two
          ? '2'
          : _choice == RankEnum.three
              ? '3'
              : _choice == RankEnum.four
                  ? '4'
                  : _choice == RankEnum.five
                      ? '5'
                      : _choice == RankEnum.six
                          ? '6'
                          : _choice == RankEnum.seven
                              ? '7'
                              : _choice == RankEnum.eight
                                  ? '8'
                                  : _choice == RankEnum.nine
                                      ? '9'
                                      : _choice == RankEnum.ten
                                          ? '10'
                                          : _choice == RankEnum.jack
                                              ? 'J'
                                              : _choice == RankEnum.queen
                                                  ? 'Q'
                                                  : 'K';

  @override
  bool operator ==(other) => other is Rank && _choice == other._choice;

  int get hashCode => _choice.hashCode;
}
