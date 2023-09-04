import 'package:flutter/material.dart';
import 'package:flutter_application_4/provider/check_provider.dart';
import 'package:flutter_application_4/provider/ingreso_provider.dart';
import 'package:flutter_application_4/provider/login_provider.dart';
import 'package:flutter_application_4/provider/obser_provider.dart';
import 'package:flutter_application_4/router/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => IngresoProvider()),
        ChangeNotifierProvider(create: (_) => CheckProvider()),
        ChangeNotifierProvider(create: (_) => ObservacionProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'App de rutas',
        debugShowCheckedModeBanner: false,
        routes: routes,
        initialRoute: 'loginPage',
        theme: ThemeData(primarySwatch: Colors.blue));
  }
}
