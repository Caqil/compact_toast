import 'package:flutter/material.dart';

/// Action button for toast
class ToastAction {
  /// Text to display on the action button
  final String text;

  /// Callback when action is tapped
  final VoidCallback onTap;

  /// Color of the action text
  final Color? textColor;

  /// Background color of the action button
  final Color? backgroundColor;

  /// Icon to display before text (optional)
  final IconData? icon;

  /// Whether tapping this action should dismiss the toast
  final bool dismissOnTap;

  const ToastAction({
    required this.text,
    required this.onTap,
    this.textColor,
    this.backgroundColor,
    this.icon,
    this.dismissOnTap = true,
  });
}
