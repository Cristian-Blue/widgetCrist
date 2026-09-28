import 'package:flutter/material.dart';

// Widget reutilizable para mostrar una imagen obtenida desde Internet.
//
// Recibe:
// - url: dirección de la imagen.
// - width: ancho opcional.
// - height: alto opcional.
//
// Es Stateless porque el widget no necesita manejar ningún estado
// propio; simplemente recibe información y muestra la imagen.
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
    // FadeInImage permite mostrar una imagen temporal mientras
    // se descarga la imagen de Internet.
    //
    // En este caso:
    //
    // placeholder → GIF que se muestra mientras carga.
    // image       → imagen que viene de Internet.
    return FadeInImage.assetNetwork(
      // Imagen que se muestra mientras se descarga
      // la imagen desde Internet.
      //
      // Este archivo debe existir dentro del proyecto.
      placeholder: 'assets/images/jar-loading.gif',

      // URL de la imagen que queremos descargar.
      image: url,

      // Tamaño que recibimos desde el widget padre.
      width: width,
      height: height,

      // Hace que la imagen ocupe todo el espacio disponible.
      // Si la proporción de la imagen es diferente,
      // parte de la imagen puede quedar recortada.
      fit: BoxFit.cover,

      // Duración de la animación utilizada cuando
      // aparece la imagen descargada.
      fadeInDuration: const Duration(milliseconds: 600),

      // Se ejecuta cuando ocurre un error al descargar
      // o mostrar la imagen.
      imageErrorBuilder: (context, error, stackTrace) {
        // En lugar de dejar un espacio vacío o mostrar
        // un error, mostramos una imagen local.
        return Image.asset(
          // Imagen que utilizaremos como alternativa.
          //
          // También debe existir dentro del proyecto.
          'assets/images/image.png',

          // Si width o height son null, utilizamos
          // todo el espacio disponible.
          width: width ?? double.infinity,
          height: height ?? double.infinity,

          // Ajustamos la imagen al espacio disponible.
          fit: BoxFit.cover,
        );
      },
    );
  }
}

// Pantalla principal.
//
// Es Stateful porque necesitamos controlar información
// que cambia durante la ejecución:
//
// - La lista de imágenes.
// - Si estamos cargando más imágenes.
// - El ScrollController.
class InfinityScreen extends StatefulWidget {
  const InfinityScreen({super.key});

  @override
  State<InfinityScreen> createState() => _InfinityScreenState();
}

class _InfinityScreenState extends State<InfinityScreen> {
  // Lista que contiene los identificadores de las imágenes.
  //
  // Inicialmente tenemos 5 imágenes:
  //
  // 1, 2, 3, 4, 5
  //
  // Posteriormente iremos agregando más elementos
  // cuando el usuario llegue cerca del final.
  List<int> imagesId = [1, 2, 3, 4, 5];

  // ScrollController permite controlar y escuchar
  // la posición actual del scroll.
  //
  // Lo utilizaremos para detectar cuándo el usuario
  // está llegando al final de la lista.
  final ScrollController _scroll = ScrollController();

  // Método utilizado por RefreshIndicator.
  //
  // Se ejecuta cuando el usuario hace el gesto de
  // arrastrar hacia abajo para actualizar.
  Future<void> onRefresh() async {
    // Simulamos una petición a un servidor.
    //
    // En una aplicación real aquí podríamos realizar
    // una petición HTTP a una API.
    await Future.delayed(const Duration(seconds: 1));

    // Verificamos que el widget todavía exista.
    //
    // Esto evita llamar a setState() después de que
    // el widget haya sido eliminado.
    if (!mounted) return;

    // Actualizamos el estado de la pantalla.
    setState(() {
      // Reemplazamos la lista actual por estas imágenes.
      imagesId = [1, 2, 3, 4, 5];
    });
  }

  // Indica si actualmente estamos cargando más imágenes.
  //
  // Se utiliza para evitar realizar varias solicitudes
  // al mismo tiempo.
  bool isLoading = false;

  @override
  void initState() {
    // Ejecutamos primero la implementación de StatefulWidget.
    super.initState();

    // Agregamos un listener al ScrollController.
    //
    // Cada vez que el usuario mueve el scroll,
    // este código puede detectar su posición.
    _scroll.addListener(() {
      // position.pixels indica cuánto hemos desplazado.
      //
      // maxScrollExtent indica cuál es la posición
      // máxima del scroll.
      //
      // Restamos 200 para comenzar a cargar imágenes
      // antes de que el usuario llegue completamente
      // al final.
      if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 200) {
        // Solicitamos más imágenes.
        _loadMore();
      }
    });
  }

  // Método encargado de cargar más imágenes.
  Future<void> _loadMore() async {
    // Si ya estamos cargando información,
    // no hacemos otra solicitud.
    //
    // Esto evita que un mismo movimiento del scroll
    // genere múltiples cargas simultáneas.
    if (isLoading) return;

    // Indicamos que comenzó la carga.
    setState(() => isLoading = true);

    // Simulamos una petición a un servidor.
    //
    // En una aplicación real aquí estaría, por ejemplo,
    // una llamada HTTP.
    await Future.delayed(const Duration(seconds: 2));

    // Generamos 5 nuevos identificadores.
    //
    // imagesId.length representa cuántas imágenes
    // tenemos actualmente.
    //
    // Por ejemplo:
    //
    // Si tenemos 5:
    //
    // length = 5
    //
    // List.generate(5, ...)
    //
    // genera:
    //
    // 5, 6, 7, 8, 9
    final next = List.generate(5, (i) => imagesId.length + i);

    // Actualizamos la pantalla.
    setState(() {
      // Agregamos las nuevas imágenes al final
      // de la lista existente.
      imagesId.addAll(next);

      // Indicamos que terminó la carga.
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Obtenemos el tamaño de la pantalla.
    //
    // Esto nos permite conocer el ancho y alto
    // disponibles.
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      // Fondo negro.
      backgroundColor: Colors.black,

      body: MediaQuery.removePadding(
        // Contexto de la pantalla.
        context: context,

        // Eliminamos el espacio superior que Flutter
        // normalmente agrega para el área segura.
        removeTop: true,

        // Eliminamos también el espacio inferior.
        removeBottom: true,

        child: RefreshIndicator(
          // Método que se ejecuta cuando el usuario
          // hace pull-to-refresh.
          onRefresh: onRefresh,

          // Distancia desde la parte superior
          // donde empieza a funcionar el indicador.
          edgeOffset: 10,

          // Grosor del indicador de carga.
          strokeWidth: 2,

          // ListView.builder permite construir
          // dinámicamente los elementos de la lista.
          //
          // Es especialmente útil cuando tenemos
          // muchos elementos.
          child: ListView.builder(
            // Conectamos nuestro ScrollController
            // con el ListView.
            //
            // De esta manera podemos saber en qué
            // posición se encuentra el usuario.
            controller: _scroll,

            // Número total de elementos que construirá
            // el ListView.
            //
            // imagesId.length → cantidad de imágenes.
            //
            // + 1 → si estamos cargando, agregamos
            // un elemento adicional para mostrar
            // el CircularProgressIndicator.
            itemCount: imagesId.length + (isLoading ? 1 : 0),

            // Construye cada elemento de la lista.
            itemBuilder: (context, index) {
              // Comprobamos si llegamos al elemento
              // adicional utilizado para mostrar
              // el indicador de carga.
              //
              // Por ejemplo:
              //
              // imagesId.length = 10
              //
              // Los índices normales son:
              //
              // 0 ... 9
              //
              // El índice 10 será utilizado para
              // mostrar el indicador.
              if (index == imagesId.length) {
                return const Padding(
                  // Espacio vertical alrededor
                  // del indicador.
                  padding: EdgeInsets.symmetric(vertical: 20),

                  child: Center(
                    // Indicador circular que informa
                    // al usuario que se están cargando
                    // más imágenes.
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                );
              }

              // Si no estamos en el indicador de carga,
              // construimos la imagen correspondiente.
              return SizedBox(
                // Ocupa todo el ancho disponible.
                width: screen.width,

                // Cada elemento tendrá 300 píxeles
                // de altura.
                height: 300,

                child: CustomNetworkImage(
                  // Construimos dinámicamente la URL.
                  //
                  // Por ejemplo, si:
                  //
                  // imagesId[index] = 5
                  //
                  // tendremos:
                  //
                  // https://picsum.photos/id/5/1080/1920
                  url: 'https://picsum.photos/id/${imagesId[index]}/1080/1920',

                  // Ancho de la imagen.
                  width: screen.width,

                  // Alto que recibe CustomNetworkImage.
                  height: screen.height,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
