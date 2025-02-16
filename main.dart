import 'package:flutter/material.dart';
import 'logo.dart'; // Импорт стартовой страницы

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Отключает баннер "Debug"
      home: StartScreen(), // Укажите стартовый экран
    );
  }
}
