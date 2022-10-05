import 'package:flutter/material.dart';

class VerticalSwipeUpDetector extends StatefulWidget {
  const VerticalSwipeUpDetector(
      {Key? key, required this.child, this.onSwipeUp, required this.threshold})
      : super(key: key);

  final Widget child;
  final double threshold;
  final void Function(double distance)? onSwipeUp;

  @override
  State<VerticalSwipeUpDetector> createState() =>
      _VerticalSwipeUpDetectorState();
}

class _VerticalSwipeUpDetectorState extends State<VerticalSwipeUpDetector> {
  Offset _startPos = Offset.zero;
  Offset _endPos = Offset.zero;
  bool _isSwiping = false;

  void _resetSwipe() {
    _startPos = _endPos = Offset.zero;
    _isSwiping = false;
  }

  void _maybeTriggerSwipe() {
    // Exit early if we're not currently swiping
    if (_isSwiping == false) return;
    // Get the distance of the swipe
    double moveDelta =
        _startPos.dy.roundToDouble() - _endPos.dy.roundToDouble();

    if (moveDelta > 0) {
      // We're swiping up
      if (moveDelta > widget.threshold) {
        // Trigger the swipe callback
        widget.onSwipeUp?.call(moveDelta);
        _resetSwipe();
      }
    } else {
      // We're not swiping up
      _resetSwipe();
    }
  }

  void _handleSwipeStart(d) {
    _isSwiping = true;
    _startPos = _endPos = d.localPosition;
  }

  void _handleSwipeUpdate(d) {
    _endPos = d.localPosition;
    _maybeTriggerSwipe();
  }

  void _handleSwipeEnd(d) {
    _maybeTriggerSwipe();
    _resetSwipe();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onVerticalDragStart: _handleSwipeStart,
        onVerticalDragUpdate: _handleSwipeUpdate,
        onVerticalDragCancel: _resetSwipe,
        onVerticalDragEnd: _handleSwipeEnd,
        child: widget.child);
  }
}
