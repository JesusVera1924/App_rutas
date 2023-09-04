import 'dart:convert';

class Cc0753 {
  Cc0753({
    required this.codEmp,
    required this.rvcAct,
    required this.fecAct,
    required this.hraAct,
    required this.obsAct,
    required this.fytAct,
    required this.srsAct,
    required this.stsAct,
  });

  String codEmp;
  String rvcAct;
  DateTime fecAct;
  String hraAct;
  String obsAct;
  DateTime fytAct;
  String srsAct;
  String stsAct;

  factory Cc0753.fromJson(String str) => Cc0753.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cc0753.fromMap(Map<String, dynamic> json) => Cc0753(
        codEmp: json["cod_emp"],
        rvcAct: json["rvc_act"],
        fecAct: DateTime.parse(json["fec_act"]),
        hraAct: json["hra_act"],
        obsAct: json["obs_act"],
        fytAct: DateTime.parse(json["fyt_act"]),
        srsAct: json["srs_act"],
        stsAct: json["sts_act"],
      );

  Map<String, dynamic> toMap() => {
        "cod_emp": codEmp,
        "rvc_act": rvcAct,
        "fec_act": fecAct.toIso8601String(),
        "hra_act": hraAct,
        "obs_act": obsAct,
        "fyt_act": fytAct.toIso8601String(),
        "srs_act": srsAct,
        "sts_act": stsAct,
      };
}
