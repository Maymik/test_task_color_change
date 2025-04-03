import 'dart:math';

import 'package:color_changer/services/storage_service.dart';
import 'package:color_changer/utils/color_utils.dart';
import 'package:color_changer/widgets/animated_text.dart';
import 'package:flutter/material.dart';

/// A stateful widget that displays a screen with interactive animations.
///
/// Tapping the screen changes the background color and triggers an animation.
///
class HelloThereScreen extends StatefulWidget {
  /// Creates a [HelloThereScreen] widget.
  const HelloThereScreen({super.key});

  @override
  HelloThereScreenState createState() => HelloThereScreenState();
}

/// The state class for [HelloThereScreen].
///
/// Manages color changes, animations.
class HelloThereScreenState extends State<HelloThereScreen>
    with SingleTickerProviderStateMixin {
  final StorageService _storageService = StorageService();
  final Random _random = Random();
  Color _backgroundColor = Colors.white;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0,
      end: pi,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _loadColor();
  }

  Future<void> _loadColor() async {
    final color = await _storageService.loadSavedColor();
    setState(() {
      _backgroundColor = color;
    });
  }

  void _changeBackgroundColor() {
    setState(() {
      _backgroundColor = generateRandomColor(_random);
    });
    _storageService.saveColor(_backgroundColor);
  }

  void _animateText() {
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  void _runActions() {
    _animateText();
    _changeBackgroundColor();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _runActions,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: _backgroundColor,
        child: Stack(
          children: [
            Center(child: AnimatedText(animation: _animation)),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Text(
                'Color: ${colorToString(_backgroundColor)}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
