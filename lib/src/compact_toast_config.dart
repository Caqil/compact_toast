import 'package:flutter/material.dart';
import 'compact_toast_enums.dart';

/// Global configuration for CompactToast
class CompactToastConfig {
  /// Default duration for toasts
  final Duration defaultDuration;

  /// Default position for toasts
  final ToastPosition defaultPosition;

  /// Default animation style
  final ToastAnimation defaultAnimation;

  /// Animation duration
  final Duration animationDuration;

  /// Whether to show close button by default
  final bool showCloseButton;

  /// Whether toasts can be dismissed by tapping
  final bool dismissOnTap;

  /// Swipe dismiss direction
  final ToastDismissDirection dismissDirection;

  /// Maximum number of toasts to display simultaneously
  final int maxToasts;

  /// Gap between multiple toasts
  final double toastGap;

  /// Whether to enable queue mode (show toasts one by one)
  final bool queueMode;

  /// Border radius for toast
  final double borderRadius;

  /// Default background color (null uses theme)
  final Color? backgroundColor;

  /// Default text color (null uses theme)
  final Color? textColor;

  /// Default border color (null uses theme)
  final Color? borderColor;

  /// Icon size
  final double iconSize;

  /// Text style
  final TextStyle? textStyle;

  /// Enable shadow
  final bool enableShadow;

  /// Enable blur effect
  final bool enableBlur;

  /// Margin from screen edges
  final double margin;

  /// Padding inside toast
  final EdgeInsets? padding;

  const CompactToastConfig({
    this.defaultDuration = const Duration(seconds: 3),
    this.defaultPosition = ToastPosition.top,
    this.defaultAnimation = ToastAnimation.slideAndFade,
    this.animationDuration = const Duration(milliseconds: 300),
    this.showCloseButton = false,
    this.dismissOnTap = false,
    this.dismissDirection = ToastDismissDirection.horizontal,
    this.maxToasts = 3,
    this.toastGap = 6.0,
    this.queueMode = false,
    this.borderRadius = 12.0,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.iconSize = 16.0,
    this.textStyle,
    this.enableShadow = true,
    this.enableBlur = false,
    this.margin = 16.0,
    this.padding,
  });

  /// Create a copy with modified properties
  CompactToastConfig copyWith({
    Duration? defaultDuration,
    ToastPosition? defaultPosition,
    ToastAnimation? defaultAnimation,
    Duration? animationDuration,
    bool? showCloseButton,
    bool? dismissOnTap,
    ToastDismissDirection? dismissDirection,
    int? maxToasts,
    double? toastGap,
    bool? queueMode,
    double? borderRadius,
    Color? backgroundColor,
    Color? textColor,
    Color? borderColor,
    double? iconSize,
    TextStyle? textStyle,
    bool? enableShadow,
    bool? enableBlur,
    double? margin,
    EdgeInsets? padding,
  }) {
    return CompactToastConfig(
      defaultDuration: defaultDuration ?? this.defaultDuration,
      defaultPosition: defaultPosition ?? this.defaultPosition,
      defaultAnimation: defaultAnimation ?? this.defaultAnimation,
      animationDuration: animationDuration ?? this.animationDuration,
      showCloseButton: showCloseButton ?? this.showCloseButton,
      dismissOnTap: dismissOnTap ?? this.dismissOnTap,
      dismissDirection: dismissDirection ?? this.dismissDirection,
      maxToasts: maxToasts ?? this.maxToasts,
      toastGap: toastGap ?? this.toastGap,
      queueMode: queueMode ?? this.queueMode,
      borderRadius: borderRadius ?? this.borderRadius,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      borderColor: borderColor ?? this.borderColor,
      iconSize: iconSize ?? this.iconSize,
      textStyle: textStyle ?? this.textStyle,
      enableShadow: enableShadow ?? this.enableShadow,
      enableBlur: enableBlur ?? this.enableBlur,
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
    );
  }
}
