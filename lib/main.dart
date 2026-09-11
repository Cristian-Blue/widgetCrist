import 'package:contador/config/theme/app_theme.dart';
import 'package:contador/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menus',
      theme: AppTheme(selectedColor: 3, isDark: false).getTheme(),
      home: HomeScreen(),
    );
  }
}
