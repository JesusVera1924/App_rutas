import 'package:flutter/material.dart';

Future<bool> dialogAcepCanc(BuildContext context, String title, String body,
    IconData iconData, Color color) async {
  bool op = false;

  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Row(
            children: [
              Icon(
                iconData,
                color: color,
                size: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  title,
                  style: TextStyle(color: color, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                body,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              )
            ],
          ),
          actions: [
            TextButton.icon(
              onPressed: () {
                op = true;
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.check_circle_outline, color: Colors.green),
              label: const Text('Aceptar'),
            ),
            TextButton.icon(
              onPressed: () {
                op = false;
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.cancel, color: Colors.red),
              label: const Text('Cancelar'),
            ),
          ],
        );
      });
  return op;
}
