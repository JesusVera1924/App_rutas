import 'dart:convert';

class Mg0030 {
  Mg0030({
    required this.cICmg,
    required this.codCmg,
    required this.nomCmg,
    required this.numMes,
  });

  String cICmg;
  String codCmg;
  String nomCmg;
  String numMes;

  factory Mg0030.fromJson(String str) => Mg0030.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Mg0030.fromMap(Map<String, dynamic> json) => Mg0030(
        cICmg: json["c_i_cmg"],
        codCmg: json["cod_cmg"],
        nomCmg: json["nom_cmg"],
        numMes: json["num_mes"],
      );

  Map<String, dynamic> toMap() => {
        "c_i_cmg": cICmg,
        "cod_cmg": codCmg,
        "nom_cmg": nomCmg,
        "num_mes": numMes,
      };
}
