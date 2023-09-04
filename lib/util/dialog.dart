import 'package:flutter/material.dart';

Future<bool> dialog(BuildContext context, String title, Widget body,
    IconData iconData, Color color,
    {presente = true}) async {
  bool op = false;

  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(thickness: 1),
            ],
          ),
          content: body,
          actions: presente
              ? [
                  TextButton(
                      style: ButtonStyle(backgroundColor:
                          MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered)) {
                          return Colors.black12;
                        }
                        return Colors.transparent;
                      })),
                      onPressed: () {
                        op = true;
                        Navigator.of(context).pop();
                      },
                      child: const Text('Aceptar',
                          style: TextStyle(fontSize: 14))),
                ]
              : null,
        );
      });
  return op;
}
