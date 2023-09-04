import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_4/model/cc0753.dart';
import 'package:flutter_application_4/provider/login_provider.dart';
import 'package:flutter_application_4/provider/obser_provider.dart';
import 'package:flutter_application_4/util/dialog_formulario.dart';
import 'package:flutter_application_4/util/util_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ObservacionPage extends StatelessWidget {
  const ObservacionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BodyPageObser();
  }
}

class BodyPageObser extends StatefulWidget {
  const BodyPageObser({Key? key}) : super(key: key);

  @override
  State<BodyPageObser> createState() => _BodyPageObserState();
}

class _BodyPageObserState extends State<BodyPageObser> {
  Color colorDivider = Colors.grey;
  bool _showFab = true;
  late Size size;

  @override
  void initState() {
    Provider.of<ObservacionProvider>(context, listen: false)
        .obtenerList(UtilView.codigoNombre);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final obsProvider = Provider.of<ObservacionProvider>(context);
    size = MediaQuery.of(context).size;
    const duration = Duration(milliseconds: 300);
    return Scaffold(
      body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            final ScrollDirection direction = notification.direction;
            setState(() {
              if (direction == ScrollDirection.reverse) {
                _showFab = false;
              } else if (direction == ScrollDirection.forward) {
                _showFab = true;
              }
            });
            return true;
          },
          child: CustomScrollView(
            /* CustomScrollView :Un ScrollView que crea efectos de desplazamiento personalizados usando astillas. */
            slivers: <Widget>[
              sliverAppBar(
                  context: context, title: "Plan actividades vendedor"),
              widgetWelcome(context: context),
              SliverToBoxAdapter(
                  child: Divider(
                thickness: 14,
                color: colorDivider,
              )),
              sliverList(obsProvider),
            ],
          )),
      floatingActionButton: AnimatedSlide(
        duration: duration,
        offset: _showFab ? Offset.zero : const Offset(0, 2),
        child: AnimatedOpacity(
          duration: duration,
          opacity: _showFab ? 1 : 0,
          child: FloatingActionButton(
            backgroundColor: UtilView.convertColor(UtilView.empresa.cl2Emp),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              dialogFormulario(context, obsProvider);
            },
          ),
        ),
      ),
    );
  }
}

// Devuelve Una barra de aplicaciones de diseño de materiales que se integra con CustomScrollView  */
SliverAppBar sliverAppBar(
    {required BuildContext context, required String title}) {
  return SliverAppBar(
    backgroundColor: UtilView.convertColor(UtilView.empresa.cl2Emp),
    primary:
        true, // Si esta barra de aplicaciones se muestra en la parte superior de la pantalla */
    pinned: true,
    excludeHeaderSemantics: true,
    title: Text(
      title,
      style: const TextStyle(color: Colors.white),
    ),
/*     actions: const [
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(Icons.search),
      )
    ], */
  );
}

Widget widgetWelcome({required BuildContext context}) {
  final loginProvider = Provider.of<LoginProvider>(context);
  return SliverToBoxAdapter(
    child: Card(
      margin: const EdgeInsets.all(0),
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        width: double.infinity,
        height: 80,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /*  Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.supervised_user_circle_rounded,
                  size: 50,
                  color: UtilView.convertColor(UtilView.empresa.cl2Emp),
                ),
              ), */
              Text.rich(
                TextSpan(
                  text: 'Usuario: ${loginProvider.nombre}\n\n',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                        text:
                            'Registra las observaciones de visitas \n tocando el botón de más en la esquina inferior derecha.',
                        style: Theme.of(context).textTheme.titleSmall),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// Una astilla que coloca múltiples hijos de caja en una matriz lineal a lo largo del eje principal
SliverList sliverList(ObservacionProvider obsProvider) {
  return SliverList(
    delegate: SliverChildBuilderDelegate(
      // Para ello, se utiliza un delegado para crear elementos a medida que se desplazan por la pantalla
      (context, index) {
        if (index == 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 8, left: 24),
                child: Text('Tus comentarios registrados',
                    style: TextStyle(fontSize: 16, color: Colors.blue)),
              ),
              getItem(index, obsProvider),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [getItem(index, obsProvider)],
        );
      },
      childCount: obsProvider.listObservacion.length,
    ),
  );
}

// Crea un item de un usaurio de muestra
Widget getItem(int index, ObservacionProvider obsProvider) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    child: Card(
      child: ListTile(
        // ListTile : Una única fila de altura fija que generalmente contiene texto, así como un icono inicial o final
        /* leading: CircleAvatar(
          // CircleAvatar :  Un círculo que representa a un usuario
          radius: 24.0,
          child: Text(
            title.substring(0, 1),
            style: const TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ), */
        title: Row(
          children: [
            Text(
                "Fecha: ${DateFormat("dd/MM/yy").format(obsProvider.listObservacion[index].fecAct)} - ${obsProvider.listObservacion[index].hraAct}",
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: InkWell(
                onTap: () {
                  UtilView.messageAccess(
                      obsProvider.listObservacion[index].obsAct,
                      UtilView.convertColor(UtilView.empresa.cl2Emp));
                },
                child: const Icon(Icons.info, color: Colors.black38),
              ),
            ),
            InkWell(
              onTap: () async {
                await obsProvider.actualizarRelanzamiento(
                    obsProvider.listObservacion[index]);
              },
              child: Icon(Icons.mark_email_unread_rounded,
                  color: Colors.green[700]),
            )
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
              obsProvider.listObservacion[index].obsAct == ""
                  ? "Sin comentario"
                  : obsProvider.listObservacion[index].obsAct,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12.0)),
        ),
      ),
    ),
  );
}
