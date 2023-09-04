// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_4/provider/obser_provider.dart';
import 'package:flutter_application_4/style/custom_inputs.dart';
import 'package:flutter_application_4/util/util_view.dart';
import 'package:intl/intl.dart';

Future dialogFormulario(
    BuildContext context, ObservacionProvider provider) async {
  final controller = TextEditingController();

  DateTime _startDate = DateTime.now();

  TimeOfDay _startTime =
      TimeOfDay(hour: _startDate.hour, minute: _startDate.minute);

  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: const Row(
                children: [
                  Icon(
                    Icons.assignment,
                    color: Colors.blueGrey,
                    size: 24,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      "Agregar Observación",
                      style: TextStyle(
                          color: Colors.blueGrey, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    readOnly: true,
                    controller: TextEditingController(
                        text: (DateFormat('dd/MM/yyyy - h:mm a'))
                            .format(_startDate)),
                    onChanged: (String value) {
                      _startDate = DateTime.parse(value);
                      _startTime = TimeOfDay(
                          hour: _startDate.hour, minute: _startDate.minute);
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      isDense: true,
                      suffix: SizedBox(
                        height: 20,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            ButtonTheme(
                                minWidth: 50.0,
                                child: MaterialButton(
                                  elevation: 0,
                                  focusElevation: 0,
                                  highlightElevation: 0,
                                  disabledElevation: 0,
                                  hoverElevation: 0,
                                  onPressed: () async {
                                    final DateTime? date = await showDatePicker(
                                      context: context,
                                      initialDate: _startDate,
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2100),
                                    );

                                    if (date != null && date != _startDate) {
                                      setState(() {
                                        _startDate = DateTime(
                                            date.year,
                                            date.month,
                                            date.day,
                                            _startTime.hour,
                                            _startTime.minute);
                                      });
                                    }
                                  },
                                  shape: const CircleBorder(),
                                  padding: EdgeInsets.zero,
                                  child: const Icon(Icons.date_range,
                                      color: Colors.grey, size: 20),
                                )),
                            ButtonTheme(
                                minWidth: 50.0,
                                child: MaterialButton(
                                  elevation: 0,
                                  focusElevation: 0,
                                  highlightElevation: 0,
                                  disabledElevation: 0,
                                  hoverElevation: 0,
                                  shape: const CircleBorder(),
                                  padding: EdgeInsets.zero,
                                  onPressed: () async {
                                    final TimeOfDay? time =
                                        await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay(
                                          hour: _startTime.hour,
                                          minute: _startTime.minute),
                                    );

                                    if (time != null && time != _startTime) {
                                      setState(() {
                                        _startTime = time;

                                        _startDate = DateTime(
                                            _startDate.year,
                                            _startDate.month,
                                            _startDate.day,
                                            _startTime.hour,
                                            _startTime.minute);
                                      });
                                    }
                                  },
                                  child: const Icon(
                                    Icons.access_time,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                ))
                          ],
                        ),
                      ),
                      focusColor: Colors.red,
                      border: const UnderlineInputBorder(),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 2.0)),
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width,
                        minWidth: 100),
                    margin: const EdgeInsets.only(top: 15, bottom: 5),
                    child: TextFormField(
                        controller: controller,
                        style: const TextStyle(color: Colors.black),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(225),
                        ],
                        maxLines: 4,
                        decoration: CustomInputs.boxInputDecorationSimple(
                            label: "Observación", hint: 'Observación')),
                  ),
                ],
              ),
              actions: [
                TextButton.icon(
                  onPressed: () async {
                    provider.saveCc0753(controller.text, UtilView.codigoNombre,
                        _startDate, _startTime.format(context));
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.check_circle_outline,
                      color: Colors.green),
                  label: const Text('Aceptar'),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.cancel, color: Colors.red),
                  label: const Text('Cancelar'),
                ),
              ],
            );
          },
        );
      });
}
