import 'package:contador/presentation/downTab/primero_screen.dart';
import 'package:contador/presentation/downTab/segundo_screen.dart';
import 'package:flutter/material.dart';

const _page = [PrimeroScreen(), SegundoScreen()];

class DowntabScreen extends StatefulWidget {
  const DowntabScreen({super.key});

  @override
  State<DowntabScreen> createState() => _DowntabScreenState();
}

class _DowntabScreenState extends State<DowntabScreen> {
  int _indicador = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[_indicador],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indicador,
        onTap: (value) {
          setState(() {
            _indicador = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.first_page), label: 'Firts'),
          BottomNavigationBarItem(icon: Icon(Icons.last_page), label: 'Second'),
        ],
      ),
    );
  }
}
