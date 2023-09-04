import 'package:flutter/material.dart';
import 'package:flutter_application_4/api/rutas_api.dart';
import 'package:flutter_application_4/model/yk0001.dart';
import 'package:flutter_application_4/util/util_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  Yk0001? usuario;
  final txtUsuario = TextEditingController();
  final txtPass = TextEditingController();
  final rutasApi = RutasApi();
  String codigo = "";
  String nombre = "";
  bool isLoading = false;

  //Guardar nombre - clave - codigo

  isLoanding(value) {
    isLoading = value;
    notifyListeners();
  }

  initClear() {
    txtUsuario.clear();
    txtPass.clear();
    codigo = "";
    nombre = "";
  }

  Future<bool> login() async {
    usuario = await rutasApi.login(txtUsuario.text, txtPass.text);
    return usuario != null;
  }

  Future fillEmp() async {
    UtilView.empresa = await rutasApi.getSettingEmp(usuario!.codEmp);
    UtilView.codigoNombre = usuario!.codUsr;
  }

  void savePreferencias() async {
    nombre = await rutasApi.getNombre(usuario!.codEmp, txtUsuario.text);
    UtilView.nombreVen = nombre;
    final SharedPreferences pf = await SharedPreferences.getInstance();
    await pf.setString('codigo', txtUsuario.text);
    await pf.setString('nombre', nombre);
  }

  Future getValues() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    codigo = preferences.getString('codigo')!;
    nombre = preferences.getString('nombre')!;
  }
}
