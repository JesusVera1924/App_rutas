// ignore_for_file: use_build_context_synchronously

import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/db/conexion_db.dart';
import 'package:flutter_application_4/model/cc0751.dart';
import 'package:flutter_application_4/model/cc0753.dart';
import 'package:flutter_application_4/provider/ingreso_provider.dart';
import 'package:flutter_application_4/util/dialog_aceptar.dart';
import 'package:flutter_application_4/util/util_view.dart';
import 'package:flutter_application_4/widget/white_card.dart';
import 'package:provider/provider.dart';

class RelanzamientoPage extends StatefulWidget {
  const RelanzamientoPage({Key? key}) : super(key: key);

  @override
  State<RelanzamientoPage> createState() => _RelanzamientoPageState();
}

class _RelanzamientoPageState extends State<RelanzamientoPage> {
  @override
  Widget build(BuildContext context) {
    final listOpt = ["Ruta", "Observación"];
    final provide = Provider.of<IngresoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Relanzamiento'),
        backgroundColor: UtilView.convertColor(UtilView.empresa.cl2Emp),
      ),
      backgroundColor: Colors.grey[300],
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Re-Lanzamientos Hojas de Rutas / Observaciones",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          Row(children: [
            Radio(
              value: "R",
              groupValue: provide.isSelect,
              onChanged: (value) {
                setState(() {
                  provide.isSelect = value as String;
                });
              },
            ),
            Text(''),
            Radio(
              value: "C",
              groupValue: provide.isSelect,
              onChanged: (value) {
                setState(() {
                  provide.isSelect = value as String;
                });
              },
            ),
            Text('Opción 2'),
          ]),
          provide.isSelect == ""
              ? WhiteCard(
                  child: SizedBox(
                  height: MediaQuery.of(context).size.height - 200,
                  child: FutureBuilder<List<Cc0751>>(
                    future: ConexionDb.instance.getAllRegistros(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Cc0751> list = snapshot.data!;
                        return list.isEmpty
                            ? Center(
                                child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset('assets/no-result.png',
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.contain),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 14),
                                    child: Text(
                                      "[0] Registros disponible",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ))
                            : ListView.separated(
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Icon(Icons.star,
                                                  color: Colors.yellow[700])),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "N°Documento: ${list[index].numRut}",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "Fecha: ${UtilView.convertDateToString(list[index].fecRut)}",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  OutlinedButton.icon(
                                                      onPressed: () async {
                                                        final opt =
                                                            await dialogAcepCanc(
                                                                context,
                                                                'Advertencia',
                                                                'Se realizara un re-envio de correo [${list[index].numRut}] estas Seguro?',
                                                                Icons.warning,
                                                                Colors.red);

                                                        if (opt) {
                                                          final listDetail =
                                                              await ConexionDb
                                                                  .instance
                                                                  .getAllRegistros2(
                                                                      list[index]
                                                                          .numRut);

                                                          await provide
                                                              .relanzarPdf(
                                                                  list[index],
                                                                  listDetail);

                                                          list = list.map((e) {
                                                            if (e.numRut ==
                                                                list[index]
                                                                    .numRut) {
                                                              e.stsRut = "E";
                                                            }
                                                            return e;
                                                          }).toList();
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'Transaccion cancelada')),
                                                          );
                                                        }

                                                        setState(() {});
                                                      },
                                                      style: OutlinedButton.styleFrom(
                                                          foregroundColor:
                                                              Colors.black,
                                                          backgroundColor:
                                                              const Color.fromARGB(
                                                                  106,
                                                                  206,
                                                                  203,
                                                                  203),
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                  vertical: 0,
                                                                  horizontal:
                                                                      5)),
                                                      icon: Icon(
                                                          list[index].stsRut == "A"
                                                              ? Icons
                                                                  .attach_email_rounded
                                                              : Icons
                                                                  .wifi_protected_setup_sharp,
                                                          color: list[index].stsRut == "A"
                                                              ? Colors.green[800]
                                                              : Colors.amber[800]),
                                                      label: Text(
                                                        "Enviar Correo",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: list[index]
                                                                        .stsRut ==
                                                                    "A"
                                                                ? Colors
                                                                    .green[800]
                                                                : Colors
                                                                    .amber[800],
                                                            fontSize: 12),
                                                      )),
                                                  const SizedBox(width: 15),
                                                  OutlinedButton.icon(
                                                      onPressed: () async {
                                                        final opt =
                                                            await dialogAcepCanc(
                                                                context,
                                                                'Advertencia',
                                                                'Se realizara un re-lanzamiento del registro [${list[index].numRut}] estas Seguro?',
                                                                Icons.warning,
                                                                Colors.red);
                                                        if (opt) {
                                                          final listDetail =
                                                              await ConexionDb
                                                                  .instance
                                                                  .getAllRegistros2(
                                                                      list[index]
                                                                          .numRut);
                                                          await provide
                                                              .relanzarDocumento(
                                                                  list[index],
                                                                  listDetail);

                                                          list.remove(
                                                              list[index]);
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'Transaccion cancelada')),
                                                          );
                                                        }
                                                      },
                                                      style: OutlinedButton.styleFrom(
                                                          foregroundColor:
                                                              Colors.black,
                                                          backgroundColor: list[index].stsRut == "A" || list[index].stsRut == "E"
                                                              ? const Color.fromARGB(
                                                                  106, 206, 203, 203)
                                                              : Colors.red,
                                                          padding: const EdgeInsets.symmetric(
                                                              vertical: 0,
                                                              horizontal: 5)),
                                                      icon: Icon(
                                                          list[index].stsRut == "A" || list[index].stsRut == "E"
                                                              ? Icons
                                                                  .upload_file_rounded
                                                              : Icons
                                                                  .playlist_remove_rounded,
                                                          color: list[index].stsRut == "A" || list[index].stsRut == "E"
                                                              ? Colors.green[800]
                                                              : Colors.red),
                                                      label: Text(
                                                        "Enviar Documento",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: list[index]
                                                                            .stsRut ==
                                                                        "A" ||
                                                                    list[index]
                                                                            .stsRut ==
                                                                        "E"
                                                                ? Colors
                                                                    .green[800]
                                                                : Colors.red,
                                                            fontSize: 12),
                                                      ))
                                                ],
                                              )
                                            ],
                                          ),
                                          const Spacer(),
                                          Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Tooltip(
                                                  textAlign: TextAlign.center,
                                                  message:
                                                      "Observación\n${list[index].obsRut}",
                                                  child: Icon(
                                                    Icons.assignment_sharp,
                                                    color:
                                                        list[index].obsRut != ""
                                                            ? Colors.green[800]
                                                            : Colors.blueGrey,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const Divider(height: 10),
                                itemCount: list.length);
                      } else if (snapshot.hasError) {
                        return Image.asset(
                          'assets/no-image.jpg',
                          width: 150,
                          height: 150,
                          fit: BoxFit.contain,
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ))
              : WhiteCard(
                  child: SizedBox(
                  height: MediaQuery.of(context).size.height - 200,
                  child: FutureBuilder<List<Cc0753>>(
                    future: ConexionDb.instance.getAllRegistros3("V002"),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Cc0753> list = snapshot.data!;
                        return list.isEmpty
                            ? Center(
                                child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset('assets/no-result.png',
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.contain),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 14),
                                    child: Text(
                                      "[0] Registros disponible",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ))
                            : ListView.separated(
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Icon(Icons.star,
                                                  color: Colors.yellow[700])),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "N°Documento: ${list[index].rvcAct}",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "Fecha: ${UtilView.convertDateToString(list[index].fecAct)}",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  OutlinedButton.icon(
                                                      onPressed: () async {
                                                        final opt =
                                                            await dialogAcepCanc(
                                                                context,
                                                                'Advertencia',
                                                                'Se realizara un re-envio de correo [${list[index].fytAct.toIso8601String()}] estas Seguro?',
                                                                Icons.warning,
                                                                Colors.red);

                                                        if (opt) {
                                                          /*  final listDetail =
                                                              await ConexionDb
                                                                  .instance
                                                                  .getAllRegistros2(
                                                                      list[index]
                                                                          .numRut);

                                                          await provide
                                                              .relanzarPdf(
                                                                  list[index],
                                                                  listDetail);

                                                          list = list.map((e) {
                                                            if (e.numRut ==
                                                                list[index]
                                                                    .numRut) {
                                                              e.stsRut = "E";
                                                            }
                                                            return e;
                                                          }).toList(); */
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'Transaccion cancelada')),
                                                          );
                                                        }

                                                        setState(() {});
                                                      },
                                                      style: OutlinedButton.styleFrom(
                                                          foregroundColor:
                                                              Colors.black,
                                                          backgroundColor:
                                                              const Color.fromARGB(
                                                                  106,
                                                                  206,
                                                                  203,
                                                                  203),
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                  vertical: 0,
                                                                  horizontal:
                                                                      5)),
                                                      icon: Icon(
                                                          list[index].stsAct == "P"
                                                              ? Icons
                                                                  .attach_email_rounded
                                                              : Icons
                                                                  .wifi_protected_setup_sharp,
                                                          color: list[index].stsAct == "P"
                                                              ? Colors.green[800]
                                                              : Colors.amber[800]),
                                                      label: Text(
                                                        "Enviar Correo",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: list[index]
                                                                        .stsAct ==
                                                                    "P"
                                                                ? Colors
                                                                    .green[800]
                                                                : Colors
                                                                    .amber[800],
                                                            fontSize: 12),
                                                      )),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const Divider(height: 10),
                                itemCount: list.length);
                      } else if (snapshot.hasError) {
                        return Image.asset(
                          'assets/no-image.jpg',
                          width: 150,
                          height: 150,
                          fit: BoxFit.contain,
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                )),
        ],
      ),
    );
  }
}
