import 'package:flutter/material.dart';
import 'package:flutter_application_4/util/util_view.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime anio = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          backgroundColor: UtilView.convertColor(UtilView.empresa.cl2Emp),
        ),
        drawer: const MenuLateral(),
        body: Column(
          children: [
            const Spacer(),
            const Center(
              child: Image(
                width: 250.0,
                height: 250.0,
                image: AssetImage('assets/cojapanwp.png'),
              ),
            ),
            const Spacer(),
            Text(
              'Powered by Tecosistemas  Copyrigh (c) ${anio.year}',
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            )
          ],
        ));
  }
}

class MenuLateral extends StatefulWidget {
  const MenuLateral({Key? key}) : super(key: key);

  @override
  State<MenuLateral> createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {
  var date = DateFormat('dd/MM/yy mm:ss').format(DateTime.now().toLocal());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 270,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 97, 21, 16)),
              child: Column(
                children: [
                  const SizedBox(height: 4),
                  const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 50,
                    child: Image(
                      height: 100,
                      width: 100,
                      image: AssetImage(
                        'assets/cojapanwp.png',
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'COD: ${UtilView.codigoNombre}',
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    UtilView.nombreVen,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              )),
          ListTile(
            leading: const Icon(
              Icons.directions,
              color: Colors.black45,
            ),
            title: const Text("Plan de rutas"),
            onTap: () async => Navigator.pushNamed(context, 'ingresoPage'),
          ),
          ListTile(
            leading: const Icon(
              Icons.check_box,
              color: Colors.green,
            ),
            title: const Text("Control de visitas [Rutas]"),
            onTap: () async => Navigator.pushNamed(context, 'checkPage'),
          ),
          ListTile(
            leading: const Icon(
              Icons.assignment,
              color: Colors.blueGrey,
            ),
            title: const Text("Plan Actividades vendedor"),
            onTap: () async => Navigator.pushNamed(context, 'observacionPage'),
          ),
          ListTile(
            leading: const Icon(
              Icons.assignment,
              color: Colors.blueGrey,
            ),
            title: const Text("Re-lanzamiento"),
            onTap: () async =>
                Navigator.pushNamed(context, 'relanzamientoPage'),
          ),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app_outlined,
              color: Colors.red,
            ),
            title: const Text("Salir"),
            onTap: () async =>
                Navigator.pushReplacementNamed(context, 'loginPage'),
          ),
        ],
      ),
    );
  }
}
