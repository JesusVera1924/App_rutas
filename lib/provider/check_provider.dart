import 'package:flutter/material.dart';
import 'package:flutter_application_4/model/cc0751.dart';
import 'package:flutter_application_4/model/cc0752M.dart';
import 'package:flutter_application_4/model/mg0032.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_4/api/rutas_api.dart';
import 'package:flutter_application_4/model/cc0754.dart';
import 'package:flutter_application_4/model/mg0030.dart';
import 'package:flutter_application_4/util/util_view.dart';

class CheckProvider extends ChangeNotifier {
  late Cc0754 cc0754;

  //----------------------------------------------------------------------------

  final txtRvc = TextEditingController();
  final txtFec = TextEditingController(
      text: DateFormat("dd/MM/yyyy").format(DateTime.now()));
  final txtNum = TextEditingController();
  final txtCta = TextEditingController();
  final txtTvc = TextEditingController();
  final txtTer = TextEditingController();
  final txtValue = TextEditingController();
  final txtCov = TextEditingController();
  final txtObs = TextEditingController();
  final txtFvs = TextEditingController(
      text: DateFormat("dd/MM/yyyy").format(DateTime.now()));

  final txtSgt = TextEditingController(
      text: DateFormat("dd/MM/yyyy").format(DateTime.now()));
  //----------------------------------------------------------------------------

  bool isTpVisita = false;
  bool isBusqueda = false;
  bool isObservacion = false;
  bool isSelect = true;

  List<Cc0752M> listClienteModel = [];
  List<Mg0032> listCliente = [];
  List<Mg0032> listAntCliente = [];
  late Mg0032 isCliente;
  late Cc0752M isClienteModel;

  final api = RutasApi();

  saveCc0754(String vendedor) {
    cc0754 = Cc0754(
        codEmp: UtilView.empresa.codEmp,
        rvcRut: vendedor,
        fecRut: UtilView.dateFormatYMD(txtFec.text),
        numRut: txtNum.text,
        ctaRut: txtCta.text.substring(0, 4),
        tvcRut: txtTvc.text,
        terRut: isSelect ? txtTer.text : "",
        covRut: txtCov.text,
        obsRut: txtObs.text,
        fvsRut: UtilView.dateFormatYMD(txtFvs.text),
        notRut: "", //campos de admin
        ucmRut: "", //campos de admin
        fcmRut:
            "2021-02-02", // se esta seteando con la hora actual del sistema en el back
        fexRut: UtilView.dateFormatYMD(
            DateFormat("dd/MM/yyyy").format(DateTime.now())),
        nexRut: "", //campos de admin
        speRut: txtNum.text == "" ? "E" : "P",
        s1sRut: "P", //estado
        s2SRut: "P", //estado
        seCRut: "0" //secuencial
        );
    api.postAdmRuta(cc0754);
    api.sendMailer(
        cc0754, txtValue.text, txtCta.text, obtenerTipo(cc0754.tvcRut));
    clearObjeto();
  }

  String obtenerTipo(String x) {
    String resp = "[";
    if (x.contains("V")) {
      resp += "Venta ";
    }
    if (x.contains("C")) {
      resp += " Cobro ";
    }
    if (x.contains("D")) {
      resp += " Devoluciòn";
    }
    return "$resp]";
  }

  clearObjeto() {
    txtRvc.clear();
    txtFec.text = DateFormat("dd/MM/yyyy").format(DateTime.now());
    txtNum.clear();
    txtCta.clear();
    txtTvc.clear();
    txtTer.clear();
    txtCov.clear();
    txtObs.clear();
    txtValue.clear();
    txtFvs.text = DateFormat("dd/MM/yyyy").format(DateTime.now());
    isTpVisita = false;
    isBusqueda = false;
    isObservacion = false;
    notifyListeners();
  }

  clearObjeto2() {
    txtRvc.clear();
    txtFec.text = DateFormat("dd/MM/yyyy").format(DateTime.now());
    txtNum.clear();
    txtCta.clear();
    txtTvc.clear();
    txtTer.clear();
    txtCov.clear();
    txtObs.clear();
    txtValue.clear();
    txtFvs.text = DateFormat("dd/MM/yyyy").format(DateTime.now());
    isTpVisita = false;
    isBusqueda = false;
    isObservacion = false;
  }

  Future getClientxVendedor(String vendedor) async {
    listCliente = await api.getMg0032Client(UtilView.empresa.codEmp, vendedor);
  }

  Future<List<Mg0030>> getObservaciones() async {
    var listObservaciones = await api.getObservacionList("71");
    return listObservaciones;
  }

  Future<List<Cc0751>> getListRutas(String vendedor) async {
    var list = await api.getCc0751List(vendedor);
    return list;
  }

  Future getListModel(String vendedor) async {
    listClienteModel.clear();
    listClienteModel =
        await api.getModelClient(UtilView.dateFormatYMD(txtFec.text), vendedor);
    isBusqueda = listClienteModel.isNotEmpty ? true : false;
    txtNum.text =
        listClienteModel.isNotEmpty ? listClienteModel.first.numRut : "";
  }
}
