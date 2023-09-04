import 'package:flutter/material.dart';
import 'package:flutter_application_4/provider/check_provider.dart';

Future<bool> dialogCheck(BuildContext context, String title, IconData iconData,
    Color color, CheckProvider provider) async {
  bool op = false;

  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
              content: SizedBox(
                width: 150,
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Reportar Acciones',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Checkbox(
                        value: provider.isSelect,
                        onChanged: (value) {
                          setState(() {
                            provider.isSelect = value!;
                          });
                        })
                  ],
                ),
              ),
              actions: [
                TextButton.icon(
                  onPressed: () {
                    op = true;
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.check_circle_outline,
                      color: Colors.green),
                  label: const Text('Guardar'),
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
          },
        );
      });
  return op;
}
