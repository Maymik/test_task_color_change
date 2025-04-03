import 'package:flutter/cupertino.dart';

/// A widget that displays animated text.
class AnimatedText extends StatelessWidget {
  /// The animation controlling the text rotation.
  final Animation<double> animation;

  /// Creates an [AnimatedText] widget.
  const AnimatedText({required this.animation, super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(animation.value),
          child: child,
        );
      },
      child: const Text(
        'Hello there!',
        style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
      ),
    );
  }
}
