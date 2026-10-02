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

    _pageController.addListener(() {
      if (_pageController.page == null) return;
      final currentPage = _pageController.page!.round();
      if (currentPage >= imagesId.length - 2) {
        _loadMore();
      }
    });
  }

  Future<void> _loadMore() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    final next = List.generate(5, (index) => imagesId.length + index);
    setState(() {
      imagesId.addAll(next);
      isLoading = false;
    });
  }

  Future<void> onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    setState(() {
      imagesId = [1, 2, 3, 4, 5];
    });
    _pageController.jumpToPage(0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,

      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          itemCount: imagesId.length + (isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == imagesId.length) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }
            return SizedBox(
              width: screen.width,
              height: screen.height,

              child: CustomNetworkImage(
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
