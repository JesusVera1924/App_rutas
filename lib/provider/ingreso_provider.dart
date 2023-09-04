import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/db/conexion_db.dart';
import 'package:flutter_application_4/model/mg0001.dart';
import 'package:flutter_application_4/model/mg0032.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_application_4/api/rutas_api.dart';
import 'package:flutter_application_4/style/custom_text.dart';
import 'package:flutter_application_4/model/cc0751.dart';
import 'package:flutter_application_4/model/cc0752.dart';
import 'package:flutter_application_4/util/util_view.dart';

class IngresoProvider extends ChangeNotifier {
  //FORMULARIO
  final txtNumero = TextEditingController();
  final txtCliente = TextEditingController();
  final txtFecha = TextEditingController(
      text: DateFormat("dd/MM/yyyy")
          .format(DateTime.now().add(const Duration(hours: -5))));
  final txtObservacion = TextEditingController();
  final txtValorv = TextEditingController();
  final txtValorr = TextEditingController();

  //ENCABEZADO DE DOCUMENTO
  late Cc0751 cabecera;
  //LISTA DE CIUDADES
  List<Mg0001> listCiudades = [];
  //LISTA DE DETALLE DEL DOCUMENTO
  List<Cc0752> listDetail = [];
  //CLIENTES RECIBIDOS Y LISTA DE SELECCION DE CLIENTES ELEGIDOS
  List<Mg0032> listCliente = [];
  List<Mg0032> listClienteSelect = [];
  //ARMAZON DEL PDF
  pw.Document? pdf;
  // CONSUMO DE SERVICIOS DE CONEXION
  final api = RutasApi();
  //
  String isSelect = "";

  initial() async {
    listClienteSelect.clear();
    listCliente.clear();
    listDetail.clear();
    txtValorr.clear();
    txtValorv.clear();
    txtObservacion.clear();
    obtenerListMg0001();
    var resp = await api.getSecuencial(UtilView.codigoNombre);
    txtNumero.text = UtilView.getSecuenceString(resp, 9);
  }

  void obtenerListMg0001() async {
    listCiudades = await api.getMg0001();
  }

  addDetail(String opt) {
    if (listClienteSelect.isNotEmpty) {
      for (var c in listClienteSelect) {
        final rsp =
            listDetail.where((ep) => ep.ctaRut.contains(c.codRef)).toList();

        if (rsp.isEmpty) {
          listDetail.add(Cc0752(
              codEmp: '01',
              rvcRuc: opt,
              numRut: txtNumero.text,
              ctaRut: c.codRef,
              fcrRut: DateTime.parse(UtilView.dateFormatYMD1(txtFecha.text)),
              speRut: 'P',
              stsRut: 'A'));
        }
      }
    }
    notifyListeners();
  }

  saveRuta(String opt) async {
    cabecera = Cc0751(
        codEmp: UtilView.empresa.codEmp,
        rvcRuc: opt,
        numRut: txtNumero.text,
        fecRut: DateTime.parse(UtilView.dateFormatYMD1(txtFecha.text)),
        obsRut: txtObservacion.text,
        ndcRut: "${listDetail.length}",
        vtaRut: txtValorv.text == "" ? 0.0 : double.parse(txtValorv.text),
        recRut: txtValorr.text == "" ? 0.0 : double.parse(txtValorr.text),
        stsRut: "A");

    await addRegistroCC0751(cabecera);
    await addRegistroCC0752(listDetail);

/*     String resp = await api.postCabecera(cabecera);

    if (resp.length == 9) {
      listDetail = listDetail.map((e) {
        e.numRut = resp;
        return e;
      }).toList();
    }

    await api.postDetalle(listDetail);
    await savePdf(txtNumero.text); */
    await initial();
    notifyListeners();
  }

  Future relanzarDocumento(Cc0751 cabecera, List<Cc0752> listDetail) async {
    if (cabecera.numRut != "") {
      await api.postCabecera(cabecera);
      await api.postDetalle(listDetail);
      await savePdf(cabecera.numRut);
      var x = await ConexionDb.instance.updateRegistros(cabecera.numRut);
      if (x == 1) {
        UtilView.messageAccess("Enviado...", Colors.blueGrey);
      }
    } else {
      UtilView.messageDanger(
          "Error de documento sin numero asignado\nComunicarse con [EL DEPARTAMENTO DE SISTEMAS]");
    }
  }

  Future relanzarPdf(Cc0751 cabecera, List<Cc0752> list) async {
    try {
      if (cabecera.numRut != "") {
        this.cabecera = cabecera;
        listDetail = list;
        obtenerListMg0001();
        await getClientxVendedor(cabecera.rvcRuc);
        await savePdf(cabecera.numRut);
        var x = await ConexionDb.instance.updateRegistroEmail(cabecera.numRut);
        if (x == 1) {
          UtilView.messageAccess("Enviado...", Colors.blueGrey);
        }
      } else {
        UtilView.messageDanger(
            "Error de documento sin numero asignado\nComunicarse con [EL DEPARTAMENTO DE SISTEMAS]");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future addRegistroCC0751(Cc0751 model) async =>
      ConexionDb.instance.insert(model);

  Future addRegistroCC0752(List<Cc0752> model) async {
    for (var e in model) {
      ConexionDb.instance.insert2(e);
    }
  }

  Future<List<Cc0751>> getDbRegistrosCC0751() async {
    var list = await ConexionDb.instance.getAllRegistros();
    return list;
  }

  Future<List<Cc0752>> getDbRegistrosCC0752(String uid) async {
    var list = await ConexionDb.instance.getAllRegistros2(uid);
    return list;
  }

  isDelete(String value) {
    listClienteSelect.removeWhere((element) => element.codRef == value);
    listDetail.removeWhere((element) => element.ctaRut == value);
    notifyListeners();
  }

  Future getClientxVendedor(String vendedor) async {
    listCliente = await api.getMg0032Client("01", vendedor);
  }

  Future<bool> isCheckSave(String opt) async {
    int hora = DateTime.now().hour - 5;
    if (hora > 0 && hora < 13) {
      final resp = await api.getVerificacionruta(
          UtilView.dateFormatYMD(txtFecha.text), opt);

      if (resp == "1") {
        return true;
      } else {
        listDetail.clear();
        UtilView.messageWarning(
            'Solo se puede generar un plan de ruta por dia');
        return false;
      }
    } else {
      UtilView.messageWarning("Botón deshabilitado máximo de ingreso 12:59 am");
      return false;
    }
  }

  Future savePdf(String numero) async {
    final data = listDetail.map((e) {
      var obj = listCliente
          .where((element) => element.codRef == e.ctaRut)
          .toList()
          .first;
      return [
        e.ctaRut,
        obj.nomRef,
        listCiudades
            .where((element) =>
                element.cIOcg == "03" && element.codOcg == obj.codCiu)
            .first
            .nomOcg,
        listCiudades
            .where((element) =>
                element.cIOcg == "02" && element.codOcg == obj.codEst)
            .first
            .nomOcg,
        e.speRut
      ];
    }).toList();

    pdf = pw.Document();
    pdf!.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(
              level: 0,
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: <pw.Widget>[
                    pw.Text('Cojapan\nPlan de Rutas',
                        textScaleFactor: 2, style: Customtext.h6),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                            'Numero: ${cabecera.numRut}\nFecha: ${DateFormat('dd/MM/yy').format(cabecera.fecRut.add(const Duration(days: -1)))}',
                            style: Customtext.h6),
                        pw.Text(
                            '${UtilView.nombreVen.trim()} (${UtilView.codigoNombre})',
                            textAlign: pw.TextAlign.right,
                            style: pw.TextStyle(
                                fontSize: 8, fontWeight: pw.FontWeight.bold)),
                      ],
                    ),
                  ])),
          pw.Padding(padding: const pw.EdgeInsets.all(5)),
          pw.Table.fromTextArray(
              context: context,
              headerStyle: Customtext.h3,
              headers: <String>[
                'Cod.',
                'Nombre de Cliente',
                "Ciudad",
                "Provincia",
                'S'
              ],
              tableWidth: pw.TableWidth.max,
              columnWidths: {
                0: const pw.FixedColumnWidth(30),
                1: const pw.IntrinsicColumnWidth(),
                2: const pw.FixedColumnWidth(45),
                3: const pw.FixedColumnWidth(60),
                4: const pw.FixedColumnWidth(20),
              },
              data: data),
        ];
      },
    ));
    final arry = await pdf!.save();
    api.sendMailerDocument(
        numero, UtilView.firmaDocumento(), base64.encode(arry));
  }
}
