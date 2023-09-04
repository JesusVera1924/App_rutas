import 'package:flutter/material.dart';
import 'package:flutter_application_4/screen/check_page.dart';
import 'package:flutter_application_4/screen/home_page.dart';
import 'package:flutter_application_4/screen/ingreso_page.dart';
import 'package:flutter_application_4/screen/login_signup.dart';
import 'package:flutter_application_4/screen/observacion_page.dart';
import 'package:flutter_application_4/screen/relanzamiento_page.dart';

final routes = <String, WidgetBuilder>{
  'loginPage': (BuildContext context) => const LoginSignup(),
  'homePage': (BuildContext context) => const HomePage(),
  'checkPage': (BuildContext context) => const CheckPage(),
  'ingresoPage': (BuildContext context) => const IngresoPage(),
  'observacionPage': (BuildContext context) => const ObservacionPage(),
  'relanzamientoPage': (BuildContext context) => const RelanzamientoPage(),
};
