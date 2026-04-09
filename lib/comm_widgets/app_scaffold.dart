import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:harcapp_core/comm_widgets/app_toast.dart';

class AppScaffold extends StatelessWidget{

  final GlobalKey? scaffoldKey;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final bool avoidKeyboard;
  final bool extendBody;
  final bool extendBodyBehindAppBar;

  const AppScaffold({
    this.scaffoldKey,
    this.appBar,
    this.drawer,
    this.body,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.avoidKeyboard = true,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false
  });

  @override
  Widget build(BuildContext context) => MediaQuery.removePadding(
      context: context,
      child: Scaffold(
        key: scaffoldKey,
        appBar: appBar,
        drawer: drawer,
        body: SafeArea(
          child: body!,
        ),
        backgroundColor: backgroundColor,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
        resizeToAvoidBottomInset: avoidKeyboard,
        extendBody: extendBody,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
      )
  );

  static void showMessage(
      BuildContext context,
      { required String text,
        String? buttonText,
        void Function()? onButtonPressed,
        Color? backgroundColor,
        Color? textColor,
        Duration duration = const Duration(seconds: 3)
      }){

    if(kIsWeb){
      _showWebToast(
        context,
        text: text,
        backgroundColor: backgroundColor,
        textColor: textColor,
        duration: duration,
      );
      return;
    }

    showAppToast(
      context,
      text: text,
      background: backgroundColor,
      textColor: textColor,
      duration: duration,

      buttonText: buttonText,
      onButtonPressed: () => onButtonPressed==null?null:onButtonPressed()
    );

  }

  static OverlayEntry? _currentToast;

  static void _showWebToast(
    BuildContext context, {
    required String text,
    Color? backgroundColor,
    Color? textColor,
    required Duration duration,
  }) {
    _currentToast?.remove();
    _currentToast = null;

    final overlay = Overlay.of(context);

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => _WebToastOverlay(
        text: text,
        backgroundColor: backgroundColor,
        textColor: textColor,
        duration: duration,
        onDismiss: () {
          entry.remove();
          if (_currentToast == entry) _currentToast = null;
        },
      ),
    );

    _currentToast = entry;
    overlay.insert(entry);
  }

}

class _WebToastOverlay extends StatefulWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final Duration duration;
  final VoidCallback onDismiss;

  const _WebToastOverlay({
    required this.text,
    this.backgroundColor,
    this.textColor,
    required this.duration,
    required this.onDismiss,
  });

  @override
  State<_WebToastOverlay> createState() => _WebToastOverlayState();
}

class _WebToastOverlayState extends State<_WebToastOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  bool _copied = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
    Future.delayed(widget.duration, _dismiss);
  }

  void _dismiss() {
    if (!mounted) return;
    _controller.reverse().then((_) {
      if (mounted) widget.onDismiss();
    });
  }

  void _copy() {
    Clipboard.setData(ClipboardData(text: widget.text));
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bg = widget.backgroundColor ?? Theme.of(context).cardColor;
    final fg = widget.textColor ?? Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: FadeTransition(
        opacity: _opacity,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.35),
                      blurRadius: 24,
                      offset: const Offset(0, 6),
                    ),
                  ],
                  border: Border.all(
                    color: fg.withValues(alpha: 0.15),
                    width: 1,
                  ),
                ),
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 14,
                  bottom: 14,
                  right: 10,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 22,
                      color: fg.withValues(alpha: 0.7),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SelectableText(
                        widget.text,
                        style: TextStyle(
                          color: fg,
                          fontSize: 16,
                          fontFamily: 'packages/harcapp_core/Lato',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: Icon(
                        _copied ? Icons.check : Icons.copy,
                        size: 20,
                        color: fg.withValues(alpha: 0.7),
                      ),
                      tooltip: 'Kopiuj',
                      onPressed: _copy,
                      padding: const EdgeInsets.all(6),
                      constraints: const BoxConstraints(),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 20,
                        color: fg.withValues(alpha: 0.7),
                      ),
                      tooltip: 'Zamknij',
                      onPressed: _dismiss,
                      padding: const EdgeInsets.all(6),
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
