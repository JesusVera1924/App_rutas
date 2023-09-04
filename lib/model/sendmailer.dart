import 'dart:convert';

class SendMaileRuta {
  SendMaileRuta({
    required this.numRef,
    required this.codRef,
    required this.nomRef,
    required this.name,
    required this.body,
  });

  String numRef;
  String codRef;
  String nomRef;
  String name;
  String body;

  factory SendMaileRuta.fromJson(String str) =>
      SendMaileRuta.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SendMaileRuta.fromMap(Map<String, dynamic> json) => SendMaileRuta(
        numRef: json["num_ref"],
        codRef: json["cod_ref"],
        nomRef: json["nom_ref"],
        name: json["name"],
        body: json["body"],
      );

  Map<String, dynamic> toMap() => {
        "num_ref": numRef,
        "cod_ref": codRef,
        "nom_ref": nomRef,
        "name": name,
        "body": body,
      };
}
