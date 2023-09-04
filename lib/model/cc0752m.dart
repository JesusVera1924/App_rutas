import 'dart:convert';

class Cc0752M {
  Cc0752M({
    required this.codEmp,
    required this.rvcRuc,
    required this.numRut,
    required this.ctaRut,
    required this.nomRef,
    required this.fcrRut,
    required this.speRut,
    required this.stsRut,
  });

  String codEmp;
  String rvcRuc;
  String numRut;
  String ctaRut;
  String nomRef;
  DateTime fcrRut;
  String speRut;
  String stsRut;

  factory Cc0752M.fromJson(String str) => Cc0752M.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cc0752M.fromMap(Map<String, dynamic> json) => Cc0752M(
        codEmp: json["cod_emp"],
        rvcRuc: json["rvc_ruc"],
        numRut: json["num_rut"],
        ctaRut: json["cta_rut"],
        nomRef: json["nom_ref"],
        fcrRut: DateTime.parse(json["fcr_rut"]),
        speRut: json["spe_rut"],
        stsRut: json["sts_rut"],
      );

  Map<String, dynamic> toMap() => {
        "cod_emp": codEmp,
        "rvc_ruc": rvcRuc,
        "num_rut": numRut,
        "cta_rut": ctaRut,
        "nom_ref": nomRef,
        "fcr_rut": fcrRut.toIso8601String(),
        "spe_rut": speRut,
        "sts_rut": stsRut,
      };
}
