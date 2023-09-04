import 'package:flutter/material.dart';
import 'package:flutter_application_4/api/rutas_api.dart';
import 'package:flutter_application_4/db/conexion_db.dart';
import 'package:flutter_application_4/model/cc0753.dart';
import 'package:flutter_application_4/util/util_view.dart';

class ObservacionProvider extends ChangeNotifier {
  List<Cc0753> listObservacion = [];
  final api = RutasApi();
  late Cc0753 obj;

  obtenerList(String codigo) async {
    listObservacion = await api.getComentario("01", codigo);
    notifyListeners();
  }

  saveCc0753(
      String observacion, String vendedor, DateTime fecha, String hora) async {
    obj = Cc0753(
        codEmp: "01",
        rvcAct: vendedor,
        fecAct: fecha,
        hraAct: hora,
        obsAct: observacion,
        fytAct: DateTime.now().add(const Duration(hours: -5)),
        srsAct: "P",
        stsAct: "P");

    //PROCESO DE GUARDADO A LA BASE DE DATOS
    await api.postComentario(obj);
    api.sendMailerDocumentInforme(obj);
    // PROCESO DE GUARDADO INTERNO
    await addRegistroCC0753(obj);
    listObservacion.add(obj);
    notifyListeners();
  }

  Future addRegistroCC0753(Cc0753 model) async =>
      ConexionDb.instance.insert3(model);

  Future actualizarRelanzamiento(Cc0753 objeto) async {
    var x = await ConexionDb.instance
        .updateRegistrosCc0753(objeto.rvcAct, objeto.fecAct, objeto.hraAct);
    if (x == 1) {
      api.sendMailerDocumentInforme(obj);
      UtilView.messageAccess("Enviado...", Colors.blueGrey);
    } else {
      UtilView.messageAccess("Ya fue re-enviado", Colors.redAccent);
    }
  }
}
