import 'package:flutter/material.dart';
import 'package:compact_toast/compact_toast.dart';

void main() {
  // Configure global toast settings
  CompactToast.configure(
    const CompactToastConfig(
      defaultDuration: Duration(seconds: 3),
      defaultPosition: ToastPosition.top,
      animationDuration: Duration(milliseconds: 300),
      enableShadow: true,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CompactToast Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const ToastDemoPage(),
    );
  }
}

class ToastDemoPage extends StatefulWidget {
  const ToastDemoPage({super.key});

  @override
  State<ToastDemoPage> createState() => _ToastDemoPageState();
}

class _ToastDemoPageState extends State<ToastDemoPage> {
  ToastController? _loadingToast;
  double _progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CompactToast Demo'),
        elevation: 2,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            title: 'Basic Toast Types',
            children: [
              _DemoButton(
                label: 'Success Toast',
                icon: Icons.check_circle,
                color: Colors.green,
                onPressed: () {
                  CompactToast.success(
                    context,
                    message: 'Operation completed successfully!',
                  );
                },
              ),
              _DemoButton(
                label: 'Error Toast',
                icon: Icons.error,
                color: Colors.red,
                onPressed: () {
                  CompactToast.error(
                    context,
                    message: 'Something went wrong. Please try again.',
                  );
                },
              ),
              _DemoButton(
                label: 'Warning Toast',
                icon: Icons.warning,
                color: Colors.orange,
                onPressed: () {
                  CompactToast.warning(
                    context,
                    message: 'Please check your input carefully.',
                  );
                },
              ),
              _DemoButton(
                label: 'Info Toast',
                icon: Icons.info,
                color: Colors.blue,
                onPressed: () {
                  CompactToast.info(
                    context,
                    message: 'Did you know? This is an info message!',
                  );
                },
              ),
            ],
          ),
          _buildSection(
            title: 'Positions',
            children: [
              _DemoButton(
                label: 'Top',
                icon: Icons.vertical_align_top,
                onPressed: () {
                  CompactToast.show(
                    context,
                    message: 'Toast at top',
                    position: ToastPosition.top,
                  );
                },
              ),
              _DemoButton(
                label: 'Top Left',
                icon: Icons.north_west,
                onPressed: () {
                  CompactToast.show(
                    context,
                    message: 'Toast at top left',
                    position: ToastPosition.topLeft,
                  );
                },
              ),
              _DemoButton(
                label: 'Top Right',
                icon: Icons.north_east,
                onPressed: () {
                  CompactToast.show(
                    context,
                    message: 'Toast at top right',
                    position: ToastPosition.topRight,
                  );
                },
              ),
              _DemoButton(
                label: 'Center',
                icon: Icons.center_focus_strong,
                onPressed: () {
                  CompactToast.show(
                    context,
                    message: 'Toast at center',
                    position: ToastPosition.center,
                  );
                },
              ),
              _DemoButton(
                label: 'Bottom',
                icon: Icons.vertical_align_bottom,
                onPressed: () {
                  CompactToast.show(
                    context,
                    message: 'Toast at bottom',
                    position: ToastPosition.bottom,
                  );
                },
              ),
            ],
          ),
          _buildSection(
            title: 'Loading & Progress',
            children: [
              _DemoButton(
                label: 'Loading Toast',
                icon: Icons.hourglass_empty,
                color: Colors.purple,
                onPressed: () {
                  _loadingToast = CompactToast.loading(
                    context,
                    message: 'Processing...',
                    showCloseButton: true,
                  );

                  // Auto dismiss after 3 seconds
                  Future.delayed(const Duration(seconds: 3), () {
                    _loadingToast?.dismiss();
                  });
                },
              ),
              _DemoButton(
                label: 'Progress Toast',
                icon: Icons.downloading,
                color: Colors.teal,
                onPressed: () async {
                  _progress = 0.0;
                  _loadingToast = CompactToast.loading(
                    context,
                    message: 'Downloading... 0%',
                    progress: 0.0,
                    showCloseButton: true,
                  );

                  // Simulate progress
                  while (_progress < 1.0) {
                    await Future.delayed(const Duration(milliseconds: 100));
                    _progress += 0.05;
                    if (_progress < 1.0) {
                      _loadingToast?.updateProgress(
                        _progress,
                        message: 'Downloading... ${(_progress * 100).toInt()}%',
                      );
                    } else {
                      _loadingToast?.dismiss();
                      if (mounted) {
                        CompactToast.success(
                          context,
                          message: 'Download complete!',
                        );
                      }
                    }
                  }
                },
              ),
            ],
          ),
          _buildSection(
            title: 'Actions',
            children: [
              _DemoButton(
                label: 'Toast with Action',
                icon: Icons.touch_app,
                color: Colors.indigo,
                onPressed: () {
                  CompactToast.show(
                    context,
                    message: 'File deleted',
                    type: ToastType.error,
                    actions: [
                      ToastAction(
                        text: 'Undo',
                        onTap: () {
                          CompactToast.success(
                            context,
                            message: 'File restored!',
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
              _DemoButton(
                label: 'Multiple Actions',
                icon: Icons.more_horiz,
                color: Colors.deepPurple,
                onPressed: () {
                  CompactToast.show(
                    context,
                    message: 'New message received',
                    type: ToastType.info,
                    duration: const Duration(seconds: 5),
                    actions: [
                      ToastAction(
                        text: 'Reply',
                        icon: Icons.reply,
                        onTap: () {
                          CompactToast.info(context, message: 'Opening reply...');
                        },
                      ),
                      ToastAction(
                        text: 'View',
                        icon: Icons.visibility,
                        onTap: () {
                          CompactToast.info(context, message: 'Opening message...');
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          _buildSection(
            title: 'Animations',
            children: [
              _DemoButton(
                label: 'Fade',
                icon: Icons.blur_on,
                onPressed: () {
                  CompactToast.show(
                    context,
                    message: 'Fade animation',
                    animationStyle: ToastAnimation.fade,
                  );
                },
              ),
              _DemoButton(
                label: 'Slide',
                icon: Icons.swipe,
                onPressed: () {
                  CompactToast.show(
                    context,
                    message: 'Slide animation',
                    animationStyle: ToastAnimation.slide,
                  );
                },
              ),
              _DemoButton(
                label: 'Scale',
                icon: Icons.zoom_out_map,
                onPressed: () {
                  CompactToast.show(
                    context,
                    message: 'Scale animation',
                    animationStyle: ToastAnimation.scale,
                  );
                },
              ),
              _DemoButton(
                label: 'Slide & Fade',
                icon: Icons.animation,
                onPressed: () {
                  CompactToast.show(
                    context,
                    message: 'Slide and fade animation',
                    animationStyle: ToastAnimation.slideAndFade,
                  );
                },
              ),
            ],
          ),
          _buildSection(
            title: 'Customization',
            children: [
              _DemoButton(
                label: 'Custom Icon',
                icon: Icons.star,
                color: Colors.amber,
                onPressed: () {
                  CompactToast.custom(
                    context,
                    message: 'You earned a star!',
                    icon: Icons.star,
                    iconColor: Colors.amber,
                  );
                },
              ),
              _DemoButton(
                label: 'Custom Colors',
                icon: Icons.palette,
                color: Colors.pink,
                onPressed: () {
                  CompactToast.show(
                    context,
                    message: 'Custom styled toast',
                    backgroundColor: Colors.pink.shade50,
                    textColor: Colors.pink.shade900,
                    iconColor: Colors.pink,
                  );
                },
              ),
              _DemoButton(
                label: 'With Close Button',
                icon: Icons.close,
                onPressed: () {
                  CompactToast.show(
                    context,
                    message: 'Tap X to close this toast',
                    showCloseButton: true,
                    duration: const Duration(seconds: 10),
                  );
                },
              ),
              _DemoButton(
                label: 'Tap to Dismiss',
                icon: Icons.touch_app,
                onPressed: () {
                  CompactToast.show(
                    context,
                    message: 'Tap anywhere on this toast to dismiss',
                    dismissOnTap: true,
                    duration: const Duration(seconds: 10),
                  );
                },
              ),
            ],
          ),
          _buildSection(
            title: 'Multiple Toasts',
            children: [
              _DemoButton(
                label: 'Show 3 Toasts',
                icon: Icons.layers,
                color: Colors.cyan,
                onPressed: () {
                  CompactToast.success(
                    context,
                    message: 'First toast',
                  );
                  Future.delayed(const Duration(milliseconds: 200), () {
                    CompactToast.info(
                      context,
                      message: 'Second toast',
                    );
                  });
                  Future.delayed(const Duration(milliseconds: 400), () {
                    CompactToast.warning(
                      context,
                      message: 'Third toast',
                    );
                  });
                },
              ),
              _DemoButton(
                label: 'Clear All Toasts',
                icon: Icons.clear_all,
                color: Colors.red,
                onPressed: () {
                  CompactToast.removeAll();
                  CompactToast.info(
                    context,
                    message: 'All toasts cleared',
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 40),
          Text(
            'Explore all the features by tapping the buttons above!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: children,
        ),
      ],
    );
  }
}

class _DemoButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? color;
  final VoidCallback onPressed;

  const _DemoButton({
    required this.label,
    required this.icon,
    this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? Theme.of(context).primaryColor;

    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor.withValues(alpha: 0.1),
        foregroundColor: buttonColor,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: buttonColor.withValues(alpha: 0.2)),
        ),
      ),
    );
  }
}
