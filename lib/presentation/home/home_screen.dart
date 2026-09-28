import 'package:contador/presentation/buttons/button_screen.dart';
import 'package:contador/presentation/downTab/downTab_screen.dart';
import 'package:contador/presentation/infinty/infinity_screen.dart';
import 'package:contador/presentation/infinty/infiny_page_screen.dart';
import 'package:contador/presentation/infinty/instagram_page.dart';
import 'package:contador/presentation/layout/drawer_custom.dart';
import 'package:contador/presentation/petition/petition_screen.dart';
import 'package:contador/presentation/text/screens/text_screen.dart';
import 'package:contador/presentation/upTab/upTab_screen.dart';
import 'package:flutter/material.dart';

const menu = [
  UptabScreen(),
  DowntabScreen(),
  ButtonScreen(),
  TextScreen(),
  PetitionScreen(),
  InfinityScreen(),
  InstagramPage(),
  InfinityPageScreen(),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome')),
      drawer: DrawerCustom(),
      body: ListView(
        children: [
          ListTile(
            title: Text('Tab inicial'),
            subtitle: Text('initial tab with orientation upper'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => menu[0]),
              );
            },
          ),
          ListTile(
            title: Text('Tab bottom'),
            subtitle: Text('initial tab with orientation upper'),
            leading: Icon(Icons.arrow_left),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => menu[1]),
              );
            },
          ),
          ListTile(
            title: Text('All Buttons'),
            subtitle: Text('Configure button general'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => menu[2]),
              );
            },
          ),
          ListTile(
            title: Text('Text'),
            subtitle: Text('initial configuration text'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => menu[3]),
              );
            },
          ),
          ListTile(
            title: Text('Petition Screen'),
            subtitle: Text('initial configure petition'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => menu[4]),
              );
            },
          ),

          ListTile(
            title: Text('Infinity Screen'),
            subtitle: Text('initial configure petition'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => menu[5]),
              );
            },
          ),

          ListTile(
            title: Text('Infinity Page Screen'),
            subtitle: Text('initial configure petition'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => menu[6]),
              );
            },
          ),

          ListTile(
            title: Text('Infinity Page Screen'),
            subtitle: Text('initial configure petition'),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => menu[7]),
              );
            },
          ),
        ],
      ),
    );
  }
}
