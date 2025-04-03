import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

/// The main application widget.
///
/// This widget serves as the root of the Flutter application.
class MyApp extends StatelessWidget {
  /// Creates a [MyApp] widget.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: HelloThereScreen()),
    );
  }
}

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
  static const String _backgroundColorKey = 'background_color';
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

    _loadSavedColor();
  }

  Future<void> _loadSavedColor() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? savedColor = prefs.getInt(_backgroundColorKey);

    if (savedColor != null) {
      setState(() {
        _backgroundColor = Color(savedColor);
      });
    }
  }

  Future<void> _saveColor(Color color) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_backgroundColorKey, color.toARGB32());
  }

  void _changeBackgroundColor() {
    setState(() {
      _backgroundColor = Color.fromARGB(
        255,
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
      );
    });

    _saveColor(_backgroundColor);
  }

  String _colorToString(Color color) {
    final int a = color.a.round();
    final int r = (color.r * 255).floor();
    final int g = (color.g * 255).floor();
    final int b = (color.b * 255).floor();
    return "alpha=$a, red=$r, green=$g, blue=$b";
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
    _colorToString(_backgroundColor);
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
            Center(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(_animation.value),
                    child: child,
                  );
                },
                child: const Text(
                  'Hello there!',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Text(
                'Color: ${_colorToString(_backgroundColor)}',
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
