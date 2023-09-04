import 'package:flutter/material.dart';
import 'package:flutter_application_4/config/palette.dart';
import 'package:flutter_application_4/model/empresa.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class UtilView {
  static List<String> tipoVisita = ["Venta", "Cobro", "Devolución"];
  static List<String> entrega = ["Entrega", "Retiro", "Ambos"];
  static late Empresa empresa;
  static String codigoNombre = "";
  static String nombreVen = "";

  static String cadenaMenu(String cadena) {
    cadena.lastIndexOf(' ');
    int count = 0;
    for (var i = 0; i < cadena.length; i++) {
      count = count + (cadena[i] == ' ' ? 1 : 0);
    }
    return '';
  }

  static String splitCharacter(String cadena, int index) {
    return cadena.split(' -')[index];
  }

  static String convertDateToString(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  static DateTime convertStringToDate2(String cadena) {
    String newString =
        "${cadena.substring(8, 10)}/${cadena.substring(5, 7)}/${cadena.substring(0, 4)} ${cadena.substring(11, 19)}";

    return DateFormat("dd/MM/yyyy HH:mm:ss")
        .parse(newString)
        .add(const Duration(hours: 5));
  }

  static DateTime convertStringToDate3(String cadena) {
    String newString =
        "${cadena.substring(8, 10)}/${cadena.substring(5, 7)}/${cadena.substring(0, 4)} ${cadena.substring(11, 19)}";

    return DateFormat("dd/MM/yyyy")
        .parse(newString)
        .add(const Duration(hours: 5));
  }

  static DateTime convertStringToDate(String cadena) {
    return DateFormat("dd/MM/yyyy").parse(cadena).add(const Duration(hours: 5));
  }

  static String dateFormatDMY(String cadena) {
    DateTime date = DateTime.parse(cadena);
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  static String firmaDocumento() {
    DateTime date = DateTime.now();
    return '${date.day.toString().padLeft(2, '0')}${date.month.toString().padLeft(2, '0')}${date.year}_${date.hour}_${date.minute}_$codigoNombre';
  }

  static String dateSumDay(int day) {
    DateTime date = DateTime.now().add(Duration(days: day));
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  static bool dateRange(String inicio, String fin, int value) {
    DateTime dateInicio = DateFormat("dd/MM/yyyy").parse(inicio);
    DateTime dateFin = DateFormat("dd/MM/yyyy").parse(fin);
    return (dateFin.year >= dateInicio.year) &&
        (dateFin.month - dateInicio.month == value);
  }

  static messageDanger(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 4,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 17.0,
      webPosition: "center",
      webBgColor: "red",
    );
  }

  static messageAccess(String message, Color color) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 12.0,
      webPosition: "center",
      webBgColor: 'rgb(46,64,83)',
    );
  }

  static messageWarning(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 17.0,
      webPosition: "center",
      webBgColor: "orange",
    );
  }

  static buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  static String getSecuenceString(String numero, int log) {
    int fix = numero.length; //tamaño del numero
    String resp = ""; // nuevo String a devolver
    String nuevo = "${int.parse(numero) + 1}";
    if (fix <= log) {
      resp = nuevo.padLeft(log, '0');
    }
    return resp;
  }

  static String dateFormatYMD1(String cadena) {
    DateTime date = DateTime.utc(
        int.parse(cadena.substring(6, 10)),
        int.parse(cadena.substring(3, 5)),
        int.parse(cadena.substring(0, 2)),
        DateTime.now().hour,
        DateTime.now().minute,
        DateTime.now().second);

    String formattedDate = DateFormat('yyyy-MM-ddTHH:mm:ss')
        .format(date.add(const Duration(hours: 5)));
    return formattedDate;
  }

  static String dateFormatYMD(String cadena) {
    DateTime date = DateTime.utc(int.parse(cadena.substring(6, 10)),
        int.parse(cadena.substring(3, 5)), int.parse(cadena.substring(0, 2)));
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return formattedDate;
  }

  static Color convertColor(String color) {
    Color colorPrimario = Palette.azulMarino;
    if (color != "") {
      final colorF = color.replaceAll("#", "0xFF");
      return colorPrimario = Color(int.parse(colorF.toUpperCase()));
    }
    return colorPrimario;
  }

  static int convertInteger(String color) {
    int colorPrimario = int.parse(color != "" ? color : "0xee29");
    return colorPrimario;
  }
}
