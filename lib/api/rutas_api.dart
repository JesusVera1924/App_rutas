import 'dart:convert';

import 'package:flutter_application_4/model/cc0751.dart';
import 'package:flutter_application_4/model/cc0752.dart';
import 'package:flutter_application_4/model/cc0752M.dart';
import 'package:flutter_application_4/model/cc0753.dart';
import 'package:flutter_application_4/model/cc0754.dart';
import 'package:flutter_application_4/model/cliente.dart';
import 'package:flutter_application_4/model/email.dart';
import 'package:flutter_application_4/model/empresa.dart';
import 'package:flutter_application_4/model/mg0001.dart';
import 'package:flutter_application_4/model/mg0030.dart';
import 'package:flutter_application_4/model/mg0032.dart';
import 'package:flutter_application_4/model/sendmailer.dart';
import 'package:flutter_application_4/model/yk0001.dart';
import 'package:flutter_application_4/util/util_view.dart';
import 'package:http/http.dart' as http;

class RutasApi {
  //181.39.96.138:8082
  static String urlBase = "192.168.3.56:8084";
  static String pathBase = "/contabilidad";
  static String pathBase2 = "/desarrollosolicitud";

  Future<Empresa> getSettingEmp(String emp) async {
    Empresa dato;
    var url = Uri.http(
        "181.39.96.138:8081", '$pathBase2/getempresa', {'empresa': emp});
    //print(url.toString());

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        dato = Empresa.fromJson(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return dato;
  }

  List<Empresa> parseJsonToList(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Empresa>((json) => Empresa.fromMap(json)).toList();
  }

  Future<Yk0001?> login(String usuario, String pass) async {
    Yk0001? dato;

    var url = Uri.http(
        urlBase, '$pathBase/loginMovil', {'usuario': usuario, 'pass': pass});

    print(url.toString());

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        dato = respuesta.body.toString() != "[]"
            ? parseListYk0001(utf8.decode(respuesta.bodyBytes)).first
            : null;
      } else {
        // print('Excepcion ${respuesta.statusCode}');
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      // print(e);
      throw ('error el en GET: $e');
    }
    return dato;
  }

  List<Yk0001> parseListYk0001(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Yk0001>((json) => Yk0001.fromMap(json)).toList();
  }

  Future<String> getNombre(String emp, String codigo) async {
    var url = Uri.http(urlBase, '$pathBase/getNombreMg0032',
        {'empresa': emp, 'cliente': codigo});

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return utf8.decode(respuesta.bodyBytes);
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<List<ClienteVen>> getClientVen(String empresa, String ven) async {
    List<ClienteVen> resul = [];

    var url = Uri.http(
        urlBase, '$pathBase/vldClientes', {'codemp': empresa, 'codven': ven});

    //print(url.toString());

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        resul = parseClient(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return resul;
  }

  List<ClienteVen> parseClient(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<ClienteVen>((json) => ClienteVen.fromMap(json)).toList();
  }

  Future<String> getSecuencial(String codigo) async {
    var url =
        Uri.http(urlBase, '$pathBase/secuenciaCc0751', {'codigo': codigo});
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return utf8.decode(respuesta.bodyBytes);
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<String> postCabecera(Cc0751 cabecera) async {
    String resp = "0";
    var url = Uri.http(urlBase, '$pathBase/saveCc0751');

    var data = cabecera.toJson();

    final resquet = await http.post(url, body: data, headers: {
      "Content-type": "application/json;charset=UTF-8",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
    });

    if (resquet.statusCode == 200) {
      resp = resquet.body;
    } else {
      throw Exception('Error de formulario,: ${resquet.statusCode}');
    }
    return resp;
  }

  Future postDetalle(List<Cc0752> detalles) async {
    List<Map> bod = [];
    var url = Uri.http(urlBase, '$pathBase/saveCc0752');

    for (var e in detalles) {
      bod.add(e.toMap());
    }

    var data = json.encode(bod);

    //print(data);

    final resquet = await http.post(url, body: data, headers: {
      "Content-type": "application/json;charset=UTF-8",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
    });

    if (resquet.statusCode != 200) {
      throw Exception('Error de formulario,: ${resquet.statusCode}');
    } else {
      //// print(resquet.body);
    }
  }

  Future<String> postComentario(Cc0753 comentario) async {
    var url = Uri.http(urlBase, '$pathBase/saveCc0753');

    var data = comentario.toJson();

    // print(data);

    final resquet = await http.post(url, body: data, headers: {
      "Content-type": "application/json;charset=UTF-8",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
    });

    if (resquet.statusCode == 200) {
      return resquet.body;
    } else {
      throw Exception('Error de formulario,: ${resquet.statusCode}');
    }
  }

  Future postAdmRuta(Cc0754 cc0754) async {
    var url = Uri.http(urlBase, '$pathBase/saveCc0754');

    var data = cc0754.toJson();
    //print(data);
    final resquet = await http.post(url, body: data, headers: {
      "Content-type": "application/json;charset=UTF-8",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
    });

    if (resquet.statusCode != 200) {
      throw Exception('Error de formulario,: ${resquet.statusCode}');
    }
  }

  Future<List<Cc0753>> getComentario(String cod, String ven) async {
    List<Cc0753> resul = [];

    var url = Uri.http(
        urlBase, '$pathBase/getCc0753', {'empresa': cod, 'vendedor': ven});

    // print(url.toString());

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        resul = parseComentario(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return resul;
  }

  List<Cc0753> parseComentario(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Cc0753>((json) => Cc0753.fromMap(json)).toList();
  }

  Future<List<Mg0030>> getObservacionList(String cod) async {
    List<Mg0030> resul = [];

    var url = Uri.http(urlBase, '$pathBase/getMg0030', {'codigo': cod});

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        resul = parseObservaciones(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return resul;
  }

  List<Mg0030> parseObservaciones(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Mg0030>((json) => Mg0030.fromMap(json)).toList();
  }

  Future<String> getVerificacionruta(String fec, String ven) async {
    var url = Uri.http(
        urlBase, '$pathBase/getCc0751Ext', {'fecha': fec, 'vendedor': ven});

    // print(url.toString());
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return utf8.decode(respuesta.bodyBytes);
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<List<Cc0752M>> getModelClient(String fec, String ven) async {
    List<Cc0752M> resul = [];

    var url = Uri.http(
        urlBase, '$pathBase/getCc0752Ext', {'fecha': fec, 'vendedor': ven});

    //print(url.toString());

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        resul = parseModelClient(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return resul;
  }

  List<Cc0752M> parseModelClient(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Cc0752M>((json) => Cc0752M.fromMap(json)).toList();
  }

  Future<List<Mg0032>> getMg0032Client(String empresa, String ven) async {
    List<Mg0032> resul = [];

    var url = Uri.http(urlBase, '$pathBase/getclienteLista',
        {'empresa': empresa, 'vendedor': ven});

    // print(url.toString());

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        resul = parseModelMg0032(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return resul;
  }

  List<Mg0032> parseModelMg0032(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Mg0032>((json) => Mg0032.fromMap(json)).toList();
  }

  Future<List<Mg0001>> getMg0001() async {
    List<Mg0001> resul = [];

    var url = Uri.http(urlBase, '$pathBase/getMg0001', {});

    //print(url.toString());

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        resul = parseModelMg0001(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return resul;
  }

  List<Mg0001> parseModelMg0001(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Mg0001>((json) => Mg0001.fromMap(json)).toList();
  }

  Future<String> sendMailerDocument(
      String numero, String name, String base) async {
    var url = Uri.http(urlBase, '$pathBase/sendCorreoR');
    var data = SendMaileRuta(
            numRef: numero,
            codRef: UtilView.codigoNombre,
            nomRef: UtilView.nombreVen,
            name: name,
            body: base)
        .toJson();
    try {
      final resquet = await http.post(url, body: data, headers: {
        "Content-type": "application/json;charset=UTF-8",
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Credentials": "true",
      });

      if (resquet.statusCode != 200) {
        throw Exception('Error de formulario,: ${resquet.statusCode}');
      } else {
        return resquet.body;
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<String> sendMailerDocumentInforme(Cc0753 bod) async {
    var url = Uri.http(urlBase, '$pathBase/sendInforme');
    var data = bod.toJson();
    try {
      final resquet = await http.post(url, body: data, headers: {
        "Content-type": "application/json;charset=UTF-8",
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Credentials": "true",
      });

      if (resquet.statusCode != 200) {
        throw Exception('Error de formulario,: ${resquet.statusCode}');
      } else {
        return resquet.body;
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<String> sendMailer(
      Cc0754 obj, String omision, String cliente, String tipo) async {
    var url = Uri.http(urlBase, '$pathBase/enviarCorreo');

    var data = Mensaje(
            mensaje:
                "<h3 % >Reporte de control de ruta </h3> <br/> - Control de visita [xp] <br/> - FECHA: ${obj.fecRut} <br/> - VENDEDOR: ${obj.rvcRut} <br/> - CLIENTE: $cliente <br/> - TIPO DE VISITA: $tipo <br/> - ACCION REALIZADA: ${obj.terRut} <br/> - NOVEDAD EN VISITA: $omision <br/> - OBSERVACION: ${obj.obsRut} <br/> <br/> Saludos,",
            nombre: "",
            adicional: "Control de visita [xp]",
            direccion: obj.rvcRut,
            numero: "",
            apellido: "")
        .toJson();

    try {
      final resquet = await http.post(url, body: data, headers: {
        "Content-type": "application/json;charset=UTF-8",
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Credentials": "true",
      });

      if (resquet.statusCode != 200) {
        throw Exception('Error de formulario,: ${resquet.statusCode}');
      } else {
        return resquet.body;
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<List<Cc0751>> getCc0751List(String vendedor) async {
    List<Cc0751> resul = [];

    var url =
        Uri.http(urlBase, '$pathBase/getCc0751Rutas', {'vendedor': vendedor});

    //print(url.toString());

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        resul = parseModelCc0751(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ${respuesta.statusCode}');
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return resul;
  }

  List<Cc0751> parseModelCc0751(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Cc0751>((json) => Cc0751.fromMap(json)).toList();
  }
}
