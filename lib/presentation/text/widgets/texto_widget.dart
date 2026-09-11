import 'package:flutter/material.dart';

enum TextType { h1, h2, h3, h4, p }

class TextoWidget extends StatelessWidget {
  final String text;
  final TextType type;

  const TextoWidget({super.key, required this.text, this.type = TextType.h1});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final style = switch (type) {
      TextType.h1 => textTheme.headlineLarge,
      TextType.h2 => textTheme.headlineMedium,
      TextType.h3 => textTheme.titleLarge,
      TextType.h4 => textTheme.titleMedium,
      TextType.p => textTheme.bodyMedium,
    };

    return Text(text, style: style);
  }
}
