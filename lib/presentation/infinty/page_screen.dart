import 'package:flutter/material.dart';

class PageScreen extends StatefulWidget {
  const PageScreen({super.key});

  @override
  State<PageScreen> createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> {
  int indicator = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Temporal')),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: PageView(
              scrollDirection: Axis.vertical,
              onPageChanged: (value) {
                setState(() {
                  indicator = value;
                });
              },
              children: [
                ImageCustom(
                  rute:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWHUI_MRurp0kyiAemaWTJEGHfPxAtD0_qyVjHTi-QmJrNV69QbVE3Fco8&s=10',
                ),
                ImageCustom(
                  rute:
                      'https://content.elmueble.com/medio/2024/11/08/beagle_84927461_1156251187_241108115623_900x900.webp',
                ),
                ImageCustom(
                  rute:
                      'https://www.vitakraft.com/fileadmin/_processed_/1/3/csm_el_origen_del_perro_3cc21c0da1.jpg',
                ),
                ImageCustom(
                  rute:
                      'https://artero.com/media/wysiwyg/dogo_burdeos_principal_650x650-removebg-preview_1.png',
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: indicator == index ? 12 : 8,
                height: indicator == index ? 12 : 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: indicator == index ? Colors.black : Colors.grey,
                ),
              );
            }),
          ),
          const SizedBox(height: 20),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('actual : $indicator'),
                Text(
                  'Los perros',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Los perros son animales domésticos que han acompañado '
                  'al ser humano durante miles de años.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ImageCustom extends StatelessWidget {
  final String rute;

  const ImageCustom({super.key, required this.rute});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      rute,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
