/// Type of toast to display
enum ToastType {
  /// Success toast with check icon
  success,

  /// Error toast with close icon
  error,

  /// Warning toast with warning icon
  warning,

  /// Info toast with info icon
  info,

  /// Loading toast with progress indicator
  loading,

  /// Custom toast with custom icon
  custom,
}

/// Position of the toast on screen
enum ToastPosition {
  /// Top center of the screen
  top,

  /// Top left of the screen
  topLeft,

  /// Top right of the screen
  topRight,

  /// Center of the screen
  center,

  /// Bottom center of the screen
  bottom,

  /// Bottom left of the screen
  bottomLeft,

  /// Bottom right of the screen
  bottomRight,
}

/// Animation style for the toast
enum ToastAnimation {
  /// Fade in animation
  fade,

  /// Slide from top/bottom based on position
  slide,

  /// Slide with fade animation
  slideAndFade,

  /// Scale animation
  scale,

  /// Scale with fade animation
  scaleAndFade,
}

/// Dismiss direction for swipe gesture
enum ToastDismissDirection {
  /// Swipe horizontally to dismiss
  horizontal,

  /// Swipe vertically to dismiss
  vertical,

  /// Swipe in any direction to dismiss
  any,

  /// Disable swipe to dismiss
  none,
}
