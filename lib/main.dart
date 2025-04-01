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
      home: Scaffold(
        body: HelloThereScreen(),
      ),
    );
  }
}

class HelloThereScreen extends StatefulWidget {
  const HelloThereScreen({super.key});

  @override
  HelloThereScreenState createState() => HelloThereScreenState();
}

class HelloThereScreenState extends State<HelloThereScreen> {
  final Random _random = Random();
  Color _backgroundColor = Colors.white;

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _changeBackgroundColor,
      child: Container(
        color: _backgroundColor,
        child: Center(
          child: Text(
            'Hello there',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
