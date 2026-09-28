import 'package:flutter/material.dart';

// Widget encargado de mostrar una imagen desde Internet.
//
// Recibe la URL y opcionalmente el ancho y alto.
class CustomNetworkImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;

  const CustomNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    // FadeInImage permite mostrar una imagen de carga
    // mientras se descarga la imagen desde Internet.
    return FadeInImage.assetNetwork(
      // Imagen que se muestra mientras la imagen
      // de Internet está cargando.
      placeholder: 'assets/images/jar-loading.gif',

      // URL de la imagen que queremos descargar.
      image: url,

      // Tamaño de la imagen.
      width: width,
      height: height,

      // La imagen ocupa todo el espacio disponible.
      // Si es necesario, recorta parte de la imagen
      // para mantener la proporción.
      fit: BoxFit.cover,

      // Duración de la transición entre la imagen
      // de carga y la imagen descargada.
      fadeInDuration: const Duration(milliseconds: 600),

      // Se ejecuta si ocurre algún error
      // al descargar la imagen.
      imageErrorBuilder: (context, error, stackTrace) {
        // Mostramos una imagen local como alternativa.
        return Image.asset(
          'assets/images/image.png',

          width: width ?? double.infinity,
          height: height ?? double.infinity,

          fit: BoxFit.cover,
        );
      },
    );
  }
}

// Pantalla principal.
//
// Utilizamos StatefulWidget porque necesitamos
// mantener información que puede cambiar,
// como la posición actual y la lista de imágenes.
class InstagramPage extends StatefulWidget {
  const InstagramPage({super.key});

  @override
  State<InstagramPage> createState() => _InstagramPageState();
}

class _InstagramPageState extends State<InstagramPage> {
  // Lista de identificadores de las imágenes.
  //
  // Posteriormente podríamos reemplazar esta lista
  // por información obtenida desde una API.
  final List<int> imagesId = [1, 2, 3, 4, 5];

  // Controlador del PageView.
  //
  // Permite controlar las páginas desde código.
  final PageController _pageController = PageController();

  @override
  void dispose() {
    // Liberamos el PageController cuando
    // la pantalla deja de existir.
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Obtenemos el tamaño de la pantalla.
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      // Fondo negro, similar a aplicaciones
      // de contenido multimedia.
      backgroundColor: Colors.black,

      // PageView.builder crea una página por cada
      // elemento de nuestra lista.
      body: PageView.builder(
        // Asociamos el controlador.
        scrollDirection: Axis.vertical,
        controller: _pageController,

        // Cantidad de páginas.
        //
        // En este caso tendremos 5 páginas.
        itemCount: imagesId.length,

        // Construye cada página.
        itemBuilder: (context, index) {
          // Cada índice representa una página.
          //
          // index = 0 → imagen 1
          // index = 1 → imagen 2
          // index = 2 → imagen 3
          // etc.
          return SizedBox(
            // Cada página ocupa todo el ancho.
            width: screen.width,

            // Cada página ocupa todo el alto.
            height: screen.height,

            child: CustomNetworkImage(
              // Construimos dinámicamente la URL.
              //
              // Ejemplo:
              //
              // index = 0
              //
              // imagesId[0] = 1
              //
              // URL:
              //
              // https://picsum.photos/id/1/1080/1920
              url: 'https://picsum.photos/id/${imagesId[index]}/1080/1920',

              width: screen.width,
              height: screen.height,
            ),
          );
        },
      ),
    );
  }
}
