import 'package:contador/presentation/downTab/primero_screen.dart';
import 'package:contador/presentation/downTab/segundo_screen.dart';
import 'package:flutter/material.dart';

class UptabScreen extends StatelessWidget {
  const UptabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          toolbarHeight: kToolbarHeight,
          title: const TabBar(
            tabs: [
              Tab(text: 'Primero', icon: Icon(Icons.ad_units)),
              Tab(text: 'Segundo', icon: Icon(Icons.dark_mode)),
            ],
          ),
        ),
        body: const TabBarView(children: [PrimeroScreen(), SegundoScreen()]),
      ),
    );
  }
}
