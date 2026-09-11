import 'package:contador/presentation/downTab/downTab_screen.dart';
import 'package:contador/presentation/upTab/upTab_screen.dart';
import 'package:flutter/material.dart';

class DrawerCustom extends StatelessWidget {
  const DrawerCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(color: Colors.blue),
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 16.0,
                  ),
                  child: Align(
                    alignment: Alignment
                        .bottomLeft, // Fuerza la alineación hacia la parte inferior
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Avatar adaptativo
                        const CircleAvatar(
                          radius:
                              30, // Proporción balanceada dentro del DrawerHeader
                          backgroundImage: NetworkImage(
                            'https://png.pngtree.com/png-vector/20231019/ourmid/pngtree-user-profile-avatar-png-image_10211467.png',
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ), // Espaciado entre la imagen y el texto
                        // Textos envueltos en Expanded para evitar desbordamiento horizontal (Overflow)
                        const Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize
                                .min, // Ocupa solo el alto que necesita el texto
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Cristian Afandor',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Ingeniero de sistemas',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('Menu superior'),
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UptabScreen()),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Menu inferior'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DowntabScreen()),
                    );
                  },
                ),
                const Divider(height: 4),
                ListTile(title: const Text('Menu superior 2')),
                ListTile(title: const Text('Menu inferior 2')),
              ],
            ),
          ),
          const Divider(height: 1),
          SafeArea(
            top: false,
            child: ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.red),
              title: const Text(
                'Cerrar Sesión',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
