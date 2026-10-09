import 'package:contador/config/theme/app_theme.dart';
import 'package:contador/presentation/home/home_screen.dart';
import 'package:contador/providers/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Menus',
      theme: AppTheme(
        selectedColor: ref.watch(colorProvider),
        isDark: false,
      ).getTheme(),
      home: HomeScreen(),
    );
  }
}
