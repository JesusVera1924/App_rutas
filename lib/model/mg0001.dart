import 'dart:convert';

class Mg0001 {
  Mg0001({
    required this.cIOcg,
    required this.codOcg,
    required this.nomOcg,
  });

  String cIOcg;
  String codOcg;
  String nomOcg;

  factory Mg0001.fromJson(String str) => Mg0001.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Mg0001.fromMap(Map<String, dynamic> json) => Mg0001(
        cIOcg: json["c_i_ocg"],
        codOcg: json["cod_ocg"],
        nomOcg: json["nom_ocg"],
      );

  Map<String, dynamic> toMap() => {
        "c_i_ocg": cIOcg,
        "cod_ocg": codOcg,
        "nom_ocg": nomOcg,
      };
}
