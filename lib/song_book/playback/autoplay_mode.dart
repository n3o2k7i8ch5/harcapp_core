/// Co po skończonym nagraniu.
enum AutoplayMode {
  /// Stop, przewinięte na początek.
  one(0),

  /// To samo jeszcze raz.
  repeat(1),

  /// Następna piosenka z nagraniem (albo losowa, patrz
  /// `SongBookSettTempl.autoplayRandom`).
  next(2);

  const AutoplayMode(this.code);

  /// Wartość do zapisu u gospodarza — stała, niezależna od kolejności.
  final int code;

  /// Kolejność przełączania przyciskiem: stop → następna → powtórka → stop.
  AutoplayMode get cycled => switch (this) {
    one => next,
    next => repeat,
    repeat => one,
  };

  static AutoplayMode fromCode(int code) =>
      values.firstWhere((m) => m.code == code, orElse: () => one);
}
