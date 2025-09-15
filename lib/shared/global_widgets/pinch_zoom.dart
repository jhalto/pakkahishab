import 'package:flutter/material.dart';

class PinchZoomWidget extends StatefulWidget {
  final Widget child;
  final double maxScale;
  final double minScale;
  final Duration resetDuration;
  final bool zoomEnabled;

  const PinchZoomWidget({
    super.key,
    required this.child,
    this.maxScale = 5.0,
    this.minScale = 1.0,
    this.resetDuration = const Duration(milliseconds: 100),
    this.zoomEnabled = true,
  });

  @override
  _PinchZoomWidgetState createState() => _PinchZoomWidgetState();
}

class _PinchZoomWidgetState extends State<PinchZoomWidget> with SingleTickerProviderStateMixin {
  late TransformationController _transformationController;
  Animation<Matrix4>? _animationReset;
  late AnimationController _animationController;

  bool _zooming = false;
  int _pointerCount = 0; // track fingers on screen

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _animationController = AnimationController(vsync: this, duration: widget.resetDuration)
      ..addListener(() {
        _transformationController.value = _animationReset!.value;
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  void _onInteractionStart(ScaleStartDetails details) {
    setState(() {
      _zooming = true;
    });
  }

  void _onInteractionEnd(ScaleEndDetails details) {
    final scale = _transformationController.value.getMaxScaleOnAxis();
    if (scale < widget.minScale) {
      _animationReset = Matrix4Tween(
        begin: _transformationController.value,
        end: Matrix4.identity(),
      ).animate(CurveTween(curve: Curves.easeOut).animate(_animationController));
      _animationController.forward(from: 0);
    }
    setState(() {
      _zooming = false;
    });
  }

 void _onPointerDown(PointerDownEvent event) {
  setState(() {
    _pointerCount++;
  });
}

void _onPointerUp(PointerUpEvent event) {
  setState(() {
    _pointerCount--;
    if (_pointerCount < 0) _pointerCount = 0;
  });
}

void _onPointerCancel(PointerCancelEvent event) {
  setState(() {
    _pointerCount--;
    if (_pointerCount < 0) _pointerCount = 0;
  });
}

@override
Widget build(BuildContext context) {
  return Listener(
    onPointerDown: _onPointerDown,
    onPointerUp: _onPointerUp,
    onPointerCancel: _onPointerCancel,
    child: InteractiveViewer(
      transformationController: _transformationController,
      maxScale: widget.maxScale,
      minScale: widget.minScale,
      panEnabled: _zooming,
      scaleEnabled: widget.zoomEnabled,
      onInteractionStart: _onInteractionStart,
      onInteractionEnd: _onInteractionEnd,
      child: widget.child,
    ),
  );
}
}