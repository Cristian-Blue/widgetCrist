import 'package:contador/presentation/text/widgets/texto_widget.dart';
import 'package:flutter/material.dart';

class TextScreen extends StatelessWidget {
  const TextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Text with style')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextoWidget(text: 'Titulo'),
            TextoWidget(text: 'Titulo', type: TextType.h2),
            TextoWidget(text: 'Titulo', type: TextType.h3),
            TextoWidget(text: 'Titulo', type: TextType.h4),
            TextoWidget(text: 'Titulo', type: TextType.p),
          ],
        ),
      ),
    );
  }
}
