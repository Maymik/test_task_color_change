import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: HelloThereScreen()),
    );
  }
}

class HelloThereScreen extends StatefulWidget {
  const HelloThereScreen({super.key});

  @override
  HelloThereScreenState createState() => HelloThereScreenState();
}

class HelloThereScreenState extends State<HelloThereScreen>
    with SingleTickerProviderStateMixin {
  final Random _random = Random();
  Color _backgroundColor = Colors.white;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0,
      end: pi,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
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
  }

  String _colorToString(Color color) {
    int a = color.a.floor();
    int r = color.red;
    int g = color.green;
    int b = color.blue;
    return "Color( a=$a, r=$r, g=$g, b=$b)";
  }

  void _animateText() {
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    _changeBackgroundColor();
    _colorToString(_backgroundColor);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _animateText,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
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
                child: Text(
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
                style: TextStyle(
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
