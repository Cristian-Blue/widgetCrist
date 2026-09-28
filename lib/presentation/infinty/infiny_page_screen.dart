import 'package:flutter/material.dart';

// Widget reutilizable para mostrar imágenes desde Internet.
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
    return FadeInImage.assetNetwork(
      // Imagen que se muestra mientras se descarga
      // la imagen desde Internet.
      placeholder: 'assets/images/jar-loading.gif',

      // URL de la imagen.
      image: url,

      // Tamaño de la imagen.
      width: width,
      height: height,

      // La imagen ocupa todo el espacio disponible.
      fit: BoxFit.cover,

      // Duración de la animación cuando aparece
      // la imagen descargada.
      fadeInDuration: const Duration(milliseconds: 600),

      // Se ejecuta cuando ocurre un error
      // al descargar la imagen.
      imageErrorBuilder: (context, error, stackTrace) {
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

// Pantalla con PageView.builder y carga infinita.
class InfinityPageScreen extends StatefulWidget {
  const InfinityPageScreen({super.key});

  @override
  State<InfinityPageScreen> createState() => _InfinityPageScreenState();
}

class _InfinityPageScreenState extends State<InfinityPageScreen> {
  // Lista inicial de imágenes.
  //
  // Posteriormente iremos agregando nuevos elementos
  // mediante _loadMore().
  List<int> imagesId = [1, 2, 3, 4, 5];

  // Controlador del PageView.
  //
  // Nos permite controlar el PageView y conocer
  // la página actual.
  final PageController _pageController = PageController();

  // Indica si actualmente estamos cargando
  // nuevos elementos.
  //
  // Evita ejecutar varias cargas al mismo tiempo.
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    // Escuchamos los cambios realizados en el PageView.
    _pageController.addListener(() {
      // Verificamos que exista una página válida.
      if (_pageController.page == null) return;

      // Obtenemos el índice de la página actual.
      //
      // page devuelve un double porque durante el
      // desplazamiento puede tener valores intermedios.
      //
      // Por ejemplo:
      //
      // 0.0 → página 1
      // 0.5 → desplazamiento entre página 1 y 2
      // 1.0 → página 2
      //
      // round() convierte ese valor al índice
      // de página más cercano.
      final currentPage = _pageController.page!.round();

      // Comenzamos a cargar cuando llegamos
      // a la penúltima página.
      //
      // Ejemplo:
      //
      // imagesId.length = 5
      //
      // 5 - 2 = 3
      //
      // Cuando currentPage sea 3:
      //
      // Página índice 3 → cuarta página
      //
      // comenzamos a cargar más información.
      if (currentPage >= imagesId.length - 2) {
        _loadMore();
      }
    });
  }

  // Método encargado de cargar más imágenes.
  Future<void> _loadMore() async {
    // Si ya estamos cargando información,
    // no hacemos otra carga.
    if (isLoading) return;

    // Indicamos que comenzó la carga.
    setState(() {
      isLoading = true;
    });

    // Simulamos una petición a una API.
    //
    // En una aplicación real aquí realizaríamos
    // la petición HTTP.
    await Future.delayed(const Duration(seconds: 2));

    // Verificamos que la pantalla todavía exista.
    if (!mounted) return;

    // Generamos cinco nuevos identificadores.
    //
    // Si tenemos:
    //
    // [1, 2, 3, 4, 5]
    //
    // se agregan nuevos elementos.
    final next = List.generate(5, (index) => imagesId.length + index);

    // Agregamos los nuevos elementos
    // a la lista existente.
    setState(() {
      imagesId.addAll(next);

      // Indicamos que terminó la carga.
      isLoading = false;
    });
  }

  // Permite actualizar la lista mediante
  // el gesto de Pull-to-Refresh.
  Future<void> onRefresh() async {
    // Simulamos una petición al servidor.
    await Future.delayed(const Duration(seconds: 1));

    // Verificamos que el widget todavía exista.
    if (!mounted) return;

    // Reiniciamos la lista.
    setState(() {
      imagesId = [1, 2, 3, 4, 5];
    });

    // Volvemos a la primera página.
    //
    // Esto es importante porque si el usuario estaba
    // en una página avanzada y reiniciamos la lista,
    // queremos comenzar nuevamente desde el principio.
    _pageController.jumpToPage(0);
  }

  @override
  void dispose() {
    // Liberamos el controlador cuando
    // la pantalla deja de existir.
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Obtenemos el tamaño de la pantalla.
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,

      body: RefreshIndicator(
        // Método ejecutado al hacer Pull-to-Refresh.
        onRefresh: onRefresh,

        child: PageView.builder(
          // Controlador del PageView.
          controller: _pageController,

          // =================================================
          // ORIENTACIÓN
          // =================================================

          // Horizontal:
          //
          // scrollDirection: Axis.horizontal,

          // Vertical:
          //
          // Página 1
          //     ↓
          // Página 2
          //     ↓
          // Página 3
          //
          // Este comportamiento es similar
          // a Reels o TikTok.
          scrollDirection: Axis.vertical,

          // Cantidad de páginas.
          //
          // Si estamos cargando, agregamos una página
          // adicional para mostrar el indicador.
          itemCount: imagesId.length + (isLoading ? 1 : 0),

          // Construye cada página.
          itemBuilder: (context, index) {
            // =================================================
            // INDICADOR DE CARGA
            // =================================================

            // Si el índice corresponde al elemento
            // adicional que agregamos mientras cargamos,
            // mostramos el indicador.
            if (index == imagesId.length) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }

            // =================================================
            // IMAGEN
            // =================================================

            // Cada página ocupa toda la pantalla.
            return SizedBox(
              width: screen.width,
              height: screen.height,

              child: CustomNetworkImage(
                // Construimos dinámicamente la URL
                // utilizando el ID correspondiente.
                url: 'https://picsum.photos/id/${imagesId[index]}/1080/1920',

                width: screen.width,
                height: screen.height,
              ),
            );
          },
        ),
      ),
    );
  }
}
