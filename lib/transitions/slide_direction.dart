/// The slide transition direction.
enum SlideDirection {
  /// Slide to [Up].
  Up,

  /// Slide to [Down].
  Down,

  /// Slide to [Start] of screen, according to the current text direction.
  ///
  /// `ltr => Left` - `rtl => Right`
  Start,

  /// Slide to [End] of screen, according to the current text direction.
  ///
  /// `ltr => Right` - `rtl => Left`
  End,

  /// Slide to [Left].
  Left,

  /// Slide to [Right].
  Right
}
