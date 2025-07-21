import 'package:flutter/material.dart';

class ZoomableWidget extends StatefulWidget {
  final Widget child;
  final double zoomScale;
  final Duration duration;

  const ZoomableWidget({
    Key? key,
    required this.child,
    this.zoomScale = 1.1,
    this.duration = const Duration(milliseconds: 200),
  }) : super(key: key);

  @override
  _ZoomableWidgetState createState() => _ZoomableWidgetState();
}

class _ZoomableWidgetState extends State<ZoomableWidget> {
  double _scale = 1.0;

  void _zoomIn() => setState(() => _scale = widget.zoomScale);
  void _zoomOut() => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _zoomIn(),
      onTapUp: (_) => _zoomOut(),
      onTapCancel: () => _zoomOut(),
      child: AnimatedScale(
        scale: _scale,
        duration: widget.duration,
        curve: Curves.easeInOut,
        child: widget.child,
      ),
    );
  }
}
