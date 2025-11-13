import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'compact_toast_action.dart';
import 'compact_toast_config.dart';
import 'compact_toast_enums.dart';

/// CompactToast - A beautiful, customizable toast notification widget
class CompactToast extends StatefulWidget {
  final ToastType type;
  final String message;
  final Duration duration;
  final VoidCallback? onClose;
  final bool showCloseButton;
  final ToastPosition position;
  final ToastAnimation animationStyle;
  final Duration animationDuration;
  final bool dismissOnTap;
  final ToastDismissDirection dismissDirection;
  final List<ToastAction>? actions;
  final Widget? customIcon;
  final IconData? icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double borderRadius;
  final double iconSize;
  final TextStyle? textStyle;
  final bool enableShadow;
  final bool enableBlur;
  final EdgeInsets? padding;
  final Widget? leading;
  final Widget? trailing;
  final double? progress;
  final ValueNotifier<double?>? progressNotifier;
  final ValueNotifier<String>? messageNotifier;

  const CompactToast({
    super.key,
    this.type = ToastType.success,
    required this.message,
    this.duration = const Duration(seconds: 3),
    this.onClose,
    this.showCloseButton = false,
    this.position = ToastPosition.top,
    this.animationStyle = ToastAnimation.slideAndFade,
    this.animationDuration = const Duration(milliseconds: 300),
    this.dismissOnTap = false,
    this.dismissDirection = ToastDismissDirection.horizontal,
    this.actions,
    this.customIcon,
    this.icon,
    this.iconColor,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderRadius = 12.0,
    this.iconSize = 16.0,
    this.textStyle,
    this.enableShadow = true,
    this.enableBlur = false,
    this.padding,
    this.leading,
    this.trailing,
    this.progress,
    this.progressNotifier,
    this.messageNotifier,
  });

  @override
  State<CompactToast> createState() => _CompactToastState();

  /// Show a toast notification
  static ToastController show(
    BuildContext context, {
    required String message,
    ToastType type = ToastType.success,
    Duration? duration,
    bool? showCloseButton,
    ToastPosition? position,
    ToastAnimation? animationStyle,
    Duration? animationDuration,
    bool? dismissOnTap,
    ToastDismissDirection? dismissDirection,
    List<ToastAction>? actions,
    Widget? customIcon,
    IconData? icon,
    Color? iconColor,
    Color? backgroundColor,
    Color? textColor,
    Color? borderColor,
    double? borderRadius,
    double? iconSize,
    TextStyle? textStyle,
    bool? enableShadow,
    bool? enableBlur,
    EdgeInsets? padding,
    Widget? leading,
    Widget? trailing,
    double? progress,
  }) {
    return _ToastManager.show(
      context,
      message: message,
      type: type,
      duration: duration,
      showCloseButton: showCloseButton,
      position: position,
      animationStyle: animationStyle,
      animationDuration: animationDuration,
      dismissOnTap: dismissOnTap,
      dismissDirection: dismissDirection,
      actions: actions,
      customIcon: customIcon,
      icon: icon,
      iconColor: iconColor,
      backgroundColor: backgroundColor,
      textColor: textColor,
      borderColor: borderColor,
      borderRadius: borderRadius,
      iconSize: iconSize,
      textStyle: textStyle,
      enableShadow: enableShadow,
      enableBlur: enableBlur,
      padding: padding,
      leading: leading,
      trailing: trailing,
      progress: progress,
    );
  }

  /// Show success toast
  static ToastController success(
    BuildContext context, {
    required String message,
    Duration? duration,
    bool? showCloseButton,
    ToastPosition? position,
    List<ToastAction>? actions,
  }) {
    return show(
      context,
      message: message,
      type: ToastType.success,
      duration: duration,
      showCloseButton: showCloseButton,
      position: position,
      actions: actions,
    );
  }

  /// Show error toast
  static ToastController error(
    BuildContext context, {
    required String message,
    Duration? duration,
    bool? showCloseButton,
    ToastPosition? position,
    List<ToastAction>? actions,
  }) {
    return show(
      context,
      message: message,
      type: ToastType.error,
      duration: duration,
      showCloseButton: showCloseButton,
      position: position,
      actions: actions,
    );
  }

  /// Show warning toast
  static ToastController warning(
    BuildContext context, {
    required String message,
    Duration? duration,
    bool? showCloseButton,
    ToastPosition? position,
    List<ToastAction>? actions,
  }) {
    return show(
      context,
      message: message,
      type: ToastType.warning,
      duration: duration,
      showCloseButton: showCloseButton,
      position: position,
      actions: actions,
    );
  }

  /// Show info toast
  static ToastController info(
    BuildContext context, {
    required String message,
    Duration? duration,
    bool? showCloseButton,
    ToastPosition? position,
    List<ToastAction>? actions,
  }) {
    return show(
      context,
      message: message,
      type: ToastType.info,
      duration: duration,
      showCloseButton: showCloseButton,
      position: position,
      actions: actions,
    );
  }

  /// Show loading toast
  static ToastController loading(
    BuildContext context, {
    required String message,
    double? progress,
    bool showCloseButton = false,
    ToastPosition? position,
  }) {
    return show(
      context,
      message: message,
      type: ToastType.loading,
      duration: Duration.zero,
      showCloseButton: showCloseButton,
      position: position,
      progress: progress,
    );
  }

  /// Show custom toast
  static ToastController custom(
    BuildContext context, {
    required String message,
    Widget? customIcon,
    IconData? icon,
    Color? iconColor,
    Duration? duration,
    bool? showCloseButton,
    ToastPosition? position,
    List<ToastAction>? actions,
  }) {
    return show(
      context,
      message: message,
      type: ToastType.custom,
      customIcon: customIcon,
      icon: icon,
      iconColor: iconColor,
      duration: duration,
      showCloseButton: showCloseButton,
      position: position,
      actions: actions,
    );
  }

  /// Remove all toasts
  static void removeAll() {
    _ToastManager.removeAll();
  }

  /// Configure global settings
  static void configure(CompactToastConfig config) {
    _ToastManager.configure(config);
  }
}

class _CompactToastState extends State<CompactToast>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    Offset slideBegin;
    switch (widget.position) {
      case ToastPosition.bottom:
      case ToastPosition.bottomLeft:
      case ToastPosition.bottomRight:
        slideBegin = const Offset(0, 0.2);
        break;
      case ToastPosition.center:
        slideBegin = const Offset(0, 0.1);
        break;
      default:
        slideBegin = const Offset(0, -0.2);
    }

    _slideAnimation = Tween<Offset>(
      begin: slideBegin,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();

    if (widget.duration != Duration.zero) {
      Future.delayed(widget.duration, () {
        if (mounted) {
          _dismiss();
        }
      });
    }
  }

  void _dismiss() {
    _animationController.reverse().then((_) {
      if (widget.onClose != null) {
        widget.onClose!();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  IconData _getIcon() {
    if (widget.icon != null) return widget.icon!;

    switch (widget.type) {
      case ToastType.success:
        return Icons.check;
      case ToastType.error:
        return Icons.close;
      case ToastType.warning:
        return Icons.warning;
      case ToastType.info:
        return Icons.info;
      case ToastType.loading:
        return Icons.hourglass_empty;
      case ToastType.custom:
        return Icons.info;
    }
  }

  Color _getIconColor(BuildContext context) {
    if (widget.iconColor != null) return widget.iconColor!;

    switch (widget.type) {
      case ToastType.success:
        return const Color(0xFF10B981);
      case ToastType.error:
        return const Color(0xFFEF4444);
      case ToastType.warning:
        return const Color(0xFFF59E0B);
      case ToastType.info:
        return const Color(0xFF3B82F6);
      case ToastType.loading:
        return Theme.of(context).primaryColor;
      case ToastType.custom:
        return Theme.of(context).primaryColor;
    }
  }

  Color _getIconTextColor() {
    return widget.type == ToastType.warning ? Colors.black : Colors.white;
  }

  Widget _buildIcon(BuildContext context) {
    if (widget.customIcon != null) {
      return SizedBox(
        width: widget.iconSize,
        height: widget.iconSize,
        child: widget.customIcon,
      );
    }

    if (widget.type == ToastType.loading) {
      // Use ValueListenableBuilder for progress updates
      if (widget.progressNotifier != null) {
        return ValueListenableBuilder<double?>(
          valueListenable: widget.progressNotifier!,
          builder: (context, progress, child) {
            return SizedBox(
              width: widget.iconSize,
              height: widget.iconSize,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation<Color>(
                  _getIconColor(context),
                ),
              ),
            );
          },
        );
      } else if (widget.progress != null) {
        return SizedBox(
          width: widget.iconSize,
          height: widget.iconSize,
          child: CircularProgressIndicator(
            value: widget.progress,
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation<Color>(
              _getIconColor(context),
            ),
          ),
        );
      }
      return SizedBox(
        width: widget.iconSize,
        height: widget.iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation<Color>(
            _getIconColor(context),
          ),
        ),
      );
    }

    return Container(
      width: widget.iconSize,
      height: widget.iconSize,
      decoration: BoxDecoration(
        color: _getIconColor(context),
        shape: BoxShape.circle,
      ),
      child: Icon(
        _getIcon(),
        color: _getIconTextColor(),
        size: widget.type == ToastType.warning ? 9 : 10,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      constraints: BoxConstraints(
        minWidth: 180,
        maxWidth: MediaQuery.of(context).size.width * 0.75,
      ),
      padding: widget.padding ??
          EdgeInsets.only(
            left: 8,
            right: widget.showCloseButton ? 4 : 8,
            top: 6,
            bottom: 6,
          ),
      decoration: BoxDecoration(
        color: widget.backgroundColor ??
            (isDark ? const Color(0xFF1F2937) : Colors.white),
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: widget.borderColor ??
              (isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: 0.08)),
          width: 0.5,
        ),
        boxShadow: widget.enableShadow
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                  spreadRadius: 0,
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.leading != null) ...[
            widget.leading!,
            const SizedBox(width: 6),
          ],
          _buildIcon(context),
          const SizedBox(width: 6),
          Flexible(
            child: _buildMessageAndActions(isDark),
          ),
          if (widget.trailing != null) ...[
            const SizedBox(width: 4),
            widget.trailing!,
          ],
          if (widget.showCloseButton) ...[
            const SizedBox(width: 4),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: _dismiss,
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Icon(
                    Icons.close,
                    color: (widget.textColor ?? (isDark ? Colors.white : Colors.black87))
                        .withValues(alpha: 0.4),
                    size: 12,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageAndActions(bool isDark) {
    final hasActions = widget.actions != null && widget.actions!.isNotEmpty;
    final actionCount = widget.actions?.length ?? 0;

    Widget buildMessageText(String message) {
      return Text(
        message,
        style: widget.textStyle ??
            TextStyle(
              color: widget.textColor ??
                  (isDark ? Colors.white : Colors.black87),
              fontWeight: FontWeight.w500,
              fontSize: 12.5,
              letterSpacing: -0.1,
              height: 1.2,
            ),
      );
    }

    Widget messageWidget = widget.messageNotifier != null
        ? ValueListenableBuilder<String>(
            valueListenable: widget.messageNotifier!,
            builder: (context, message, child) {
              return buildMessageText(message);
            },
          )
        : buildMessageText(widget.message);

    // If single action, show it on the right of message
    if (hasActions && actionCount == 1) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: messageWidget,
          ),
          const SizedBox(width: 8),
          _buildAction(context, widget.actions!.first),
        ],
      );
    }

    // If multiple actions or no actions, show message above actions
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        messageWidget,
        if (hasActions && actionCount > 1) ...[
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Wrap(
              spacing: 8,
              runSpacing: 6,
              alignment: WrapAlignment.end,
              children: widget.actions!
                  .map((action) => _buildAction(context, action))
                  .toList(),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildAction(BuildContext context, ToastAction action) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final actionColor = action.textColor ?? theme.primaryColor;

    return Container(
      decoration: BoxDecoration(
        color: action.backgroundColor ??
            (isDark
                ? actionColor.withValues(alpha: 0.2)
                : actionColor.withValues(alpha: 0.12)),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: action.backgroundColor != null
              ? Colors.transparent
              : actionColor.withValues(alpha: 0.25),
          width: 0.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: () {
            action.onTap();
            if (action.dismissOnTap) {
              _dismiss();
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (action.icon != null) ...[
                  Icon(
                    action.icon,
                    size: 12,
                    color: actionColor,
                  ),
                  const SizedBox(width: 4),
                ],
                Text(
                  action.text,
                  style: TextStyle(
                    color: actionColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 11.5,
                    letterSpacing: 0.1,
                    height: 1.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedToast(Widget child) {
    switch (widget.animationStyle) {
      case ToastAnimation.fade:
        return FadeTransition(
          opacity: _fadeAnimation,
          child: child,
        );
      case ToastAnimation.slide:
        return SlideTransition(
          position: _slideAnimation,
          child: child,
        );
      case ToastAnimation.slideAndFade:
        return SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: child,
          ),
        );
      case ToastAnimation.scale:
        return ScaleTransition(
          scale: _scaleAnimation,
          child: child,
        );
      case ToastAnimation.scaleAndFade:
        return ScaleTransition(
          scale: _scaleAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: child,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = _buildContent(context);

    if (widget.enableBlur) {
      content = ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: content,
        ),
      );
    }

    if (widget.dismissOnTap) {
      content = GestureDetector(
        onTap: _dismiss,
        child: content,
      );
    }

    if (widget.dismissDirection != ToastDismissDirection.none) {
      content = Dismissible(
        key: UniqueKey(),
        direction: _getDismissDirection(),
        onDismissed: (_) => _dismiss(),
        child: content,
      );
    }

    return _buildAnimatedToast(content);
  }

  DismissDirection _getDismissDirection() {
    switch (widget.dismissDirection) {
      case ToastDismissDirection.horizontal:
        return DismissDirection.horizontal;
      case ToastDismissDirection.vertical:
        return DismissDirection.vertical;
      case ToastDismissDirection.any:
        return DismissDirection.horizontal;
      case ToastDismissDirection.none:
        return DismissDirection.none;
    }
  }
}

/// Controller for managing a toast
class ToastController {
  final VoidCallback _dismiss;
  final ValueNotifier<double?>? _progressNotifier;
  final ValueNotifier<String>? _messageNotifier;

  ToastController._(
    this._dismiss, {
    ValueNotifier<double?>? progressNotifier,
    ValueNotifier<String>? messageNotifier,
  })  : _progressNotifier = progressNotifier,
        _messageNotifier = messageNotifier;

  /// Dismiss the toast
  void dismiss() => _dismiss();

  /// Update progress (only for loading toasts)
  void updateProgress(double progress, {String? message}) {
    _progressNotifier?.value = progress;
    if (message != null) {
      _messageNotifier?.value = message;
    }
  }

  /// Update message
  void updateMessage(String message) {
    _messageNotifier?.value = message;
  }
}

/// Private toast manager
class _ToastManager {
  static final List<OverlayEntry> _entries = [];
  static CompactToastConfig _config = const CompactToastConfig();
  static final List<_ToastData> _queue = [];
  static bool _isShowingToast = false;

  static void configure(CompactToastConfig config) {
    _config = config;
  }

  static ToastController show(
    BuildContext context, {
    required String message,
    ToastType? type,
    Duration? duration,
    bool? showCloseButton,
    ToastPosition? position,
    ToastAnimation? animationStyle,
    Duration? animationDuration,
    bool? dismissOnTap,
    ToastDismissDirection? dismissDirection,
    List<ToastAction>? actions,
    Widget? customIcon,
    IconData? icon,
    Color? iconColor,
    Color? backgroundColor,
    Color? textColor,
    Color? borderColor,
    double? borderRadius,
    double? iconSize,
    TextStyle? textStyle,
    bool? enableShadow,
    bool? enableBlur,
    EdgeInsets? padding,
    Widget? leading,
    Widget? trailing,
    double? progress,
  }) {
    final toastData = _ToastData(
      context: context,
      message: message,
      type: type ?? ToastType.success,
      duration: duration ?? _config.defaultDuration,
      showCloseButton: showCloseButton ?? _config.showCloseButton,
      position: position ?? _config.defaultPosition,
      animationStyle: animationStyle ?? _config.defaultAnimation,
      animationDuration: animationDuration ?? _config.animationDuration,
      dismissOnTap: dismissOnTap ?? _config.dismissOnTap,
      dismissDirection: dismissDirection ?? _config.dismissDirection,
      actions: actions,
      customIcon: customIcon,
      icon: icon,
      iconColor: iconColor,
      backgroundColor: backgroundColor ?? _config.backgroundColor,
      textColor: textColor ?? _config.textColor,
      borderColor: borderColor ?? _config.borderColor,
      borderRadius: borderRadius ?? _config.borderRadius,
      iconSize: iconSize ?? _config.iconSize,
      textStyle: textStyle ?? _config.textStyle,
      enableShadow: enableShadow ?? _config.enableShadow,
      enableBlur: enableBlur ?? _config.enableBlur,
      padding: padding ?? _config.padding,
      leading: leading,
      trailing: trailing,
      progress: progress,
    );

    if (_config.queueMode) {
      _queue.add(toastData);
      if (!_isShowingToast) {
        _showNextInQueue();
      }
      return ToastController._(() => _removeFromQueue(toastData));
    } else {
      return _showToast(toastData);
    }
  }

  static void _showNextInQueue() {
    if (_queue.isEmpty) {
      _isShowingToast = false;
      return;
    }

    _isShowingToast = true;
    final toastData = _queue.removeAt(0);
    _showToast(toastData);
  }

  static ToastController _showToast(_ToastData data) {
    if (_entries.length >= _config.maxToasts) {
      _entries.first.remove();
      _entries.removeAt(0);
    }

    OverlayEntry? entry;
    ValueNotifier<double?>? progressNotifier;
    ValueNotifier<String>? messageNotifier;

    // Create notifiers for loading toasts to enable updates
    if (data.type == ToastType.loading) {
      progressNotifier = ValueNotifier<double?>(data.progress);
      messageNotifier = ValueNotifier<String>(data.message);
    }

    void removeEntry() {
      entry?.remove();
      if (entry != null) {
        _entries.remove(entry);
      }
      progressNotifier?.dispose();
      messageNotifier?.dispose();
      if (_config.queueMode) {
        _showNextInQueue();
      }
    }

    entry = OverlayEntry(
      builder: (context) => _buildPositionedToast(
        context,
        position: data.position,
        index: _entries.length,
        child: Material(
          color: Colors.transparent,
          child: CompactToast(
            type: data.type,
            message: data.message,
            duration: data.duration,
            showCloseButton: data.showCloseButton,
            position: data.position,
            animationStyle: data.animationStyle,
            animationDuration: data.animationDuration,
            dismissOnTap: data.dismissOnTap,
            dismissDirection: data.dismissDirection,
            actions: data.actions,
            customIcon: data.customIcon,
            icon: data.icon,
            iconColor: data.iconColor,
            backgroundColor: data.backgroundColor,
            textColor: data.textColor,
            borderColor: data.borderColor,
            borderRadius: data.borderRadius,
            iconSize: data.iconSize,
            textStyle: data.textStyle,
            enableShadow: data.enableShadow,
            enableBlur: data.enableBlur,
            padding: data.padding,
            leading: data.leading,
            trailing: data.trailing,
            progress: data.progress,
            progressNotifier: progressNotifier,
            messageNotifier: messageNotifier,
            onClose: removeEntry,
          ),
        ),
      ),
    );

    _entries.add(entry);
    Overlay.of(data.context).insert(entry);

    return ToastController._(
      removeEntry,
      progressNotifier: progressNotifier,
      messageNotifier: messageNotifier,
    );
  }

  static void _removeFromQueue(_ToastData data) {
    _queue.remove(data);
  }

  static Widget _buildPositionedToast(
    BuildContext context, {
    required ToastPosition position,
    required int index,
    required Widget child,
  }) {
    final padding = MediaQuery.of(context).padding;
    final margin = _config.margin;
    final offset = index * (_config.toastGap + 36);

    switch (position) {
      case ToastPosition.top:
        return Positioned(
          top: padding.top + margin + offset,
          left: margin,
          right: margin,
          child: Align(
            alignment: Alignment.topCenter,
            child: child,
          ),
        );

      case ToastPosition.topLeft:
        return Positioned(
          top: padding.top + margin + offset,
          left: margin,
          child: child,
        );

      case ToastPosition.topRight:
        return Positioned(
          top: padding.top + margin + offset,
          right: margin,
          child: child,
        );

      case ToastPosition.center:
        return Center(child: child);

      case ToastPosition.bottom:
        return Positioned(
          bottom: padding.bottom + margin + offset,
          left: margin,
          right: margin,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: child,
          ),
        );

      case ToastPosition.bottomLeft:
        return Positioned(
          bottom: padding.bottom + margin + offset,
          left: margin,
          child: child,
        );

      case ToastPosition.bottomRight:
        return Positioned(
          bottom: padding.bottom + margin + offset,
          right: margin,
          child: child,
        );
    }
  }

  static void removeAll() {
    for (final entry in _entries) {
      entry.remove();
    }
    _entries.clear();
    _queue.clear();
    _isShowingToast = false;
  }
}

class _ToastData {
  final BuildContext context;
  final String message;
  final ToastType type;
  final Duration duration;
  final bool showCloseButton;
  final ToastPosition position;
  final ToastAnimation animationStyle;
  final Duration animationDuration;
  final bool dismissOnTap;
  final ToastDismissDirection dismissDirection;
  final List<ToastAction>? actions;
  final Widget? customIcon;
  final IconData? icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double borderRadius;
  final double iconSize;
  final TextStyle? textStyle;
  final bool enableShadow;
  final bool enableBlur;
  final EdgeInsets? padding;
  final Widget? leading;
  final Widget? trailing;
  final double? progress;

  _ToastData({
    required this.context,
    required this.message,
    required this.type,
    required this.duration,
    required this.showCloseButton,
    required this.position,
    required this.animationStyle,
    required this.animationDuration,
    required this.dismissOnTap,
    required this.dismissDirection,
    this.actions,
    this.customIcon,
    this.icon,
    this.iconColor,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    required this.borderRadius,
    required this.iconSize,
    this.textStyle,
    required this.enableShadow,
    required this.enableBlur,
    this.padding,
    this.leading,
    this.trailing,
    this.progress,
  });
}
