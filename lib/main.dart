import 'package:color_changer/features/hello_there_screen.dart';
import 'package:flutter/material.dart';

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
