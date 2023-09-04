import 'dart:convert';

class ClienteVen {
  ClienteVen({
    required this.id,
    required this.empresa,
    required this.cliente,
    required this.ncliente,
    required this.nclienteAux,
    required this.direccion,
    required this.ciudad,
    required this.provincia,
    required this.ruc,
    required this.telefono,
    required this.vendedor,
    required this.formaPago,
    required this.mail1,
    required this.mail2,
    required this.descuento,
    required this.persona,
  });

  int id;
  String empresa;
  String cliente;
  String ncliente;
  String nclienteAux;
  String direccion;
  String ciudad;
  String provincia;
  String ruc;
  String telefono;
  String vendedor;
  String formaPago;
  String mail1;
  String mail2;
  double descuento;
  int persona;

  factory ClienteVen.fromJson(String str) =>
      ClienteVen.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ClienteVen.fromMap(Map<String, dynamic> json) => ClienteVen(
        id: json["id"],
        empresa: json["empresa"],
        cliente: json["cliente"],
        ncliente: json["ncliente"],
        nclienteAux: json["ncliente_aux"],
        direccion: json["direccion"],
        ciudad: json["ciudad"],
        provincia: json["provincia"],
        ruc: json["ruc"],
        telefono: json["telefono"],
        vendedor: json["vendedor"],
        formaPago: json["forma_pago"],
        mail1: json["mail1"],
        mail2: json["mail2"],
        descuento: json["descuento"].toDouble(),
        persona: json["persona"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "empresa": empresa,
        "cliente": cliente,
        "ncliente": ncliente,
        "ncliente_aux": nclienteAux,
        "direccion": direccion,
        "ciudad": ciudad,
        "provincia": provincia,
        "ruc": ruc,
        "telefono": telefono,
        "vendedor": vendedor,
        "forma_pago": formaPago,
        "mail1": mail1,
        "mail2": mail2,
        "descuento": descuento,
        "persona": persona,
      };
}
