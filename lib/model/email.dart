import 'dart:convert';

class Mensaje {
  Mensaje({
    required this.adicional,
    required this.nombre,
    required this.apellido,
    required this.direccion,
    required this.numero,
    required this.mensaje,
  });

  String adicional;
  String nombre;
  String apellido;
  String direccion;
  String numero;
  String mensaje;

  factory Mensaje.fromJson(String str) => Mensaje.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Mensaje.fromMap(Map<String, dynamic> json) => Mensaje(
        adicional: json["adicional"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        direccion: json["direccion"],
        numero: json["numero"],
        mensaje: json["mensaje"],
      );

  Map<String, dynamic> toMap() => {
        "adicional": adicional,
        "nombre": nombre,
        "apellido": apellido,
        "direccion": direccion,
        "numero": numero,
        "mensaje": mensaje,
      };
}
