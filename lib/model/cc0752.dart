// ignore_for_file: unnecessary_overrides

import 'dart:convert';

class Cc0752 {
  Cc0752({
    required this.codEmp,
    required this.rvcRuc,
    required this.numRut,
    required this.ctaRut,
    required this.fcrRut,
    required this.speRut,
    required this.stsRut,
  });

  String codEmp;
  String rvcRuc;
  String numRut;
  String ctaRut;
  DateTime fcrRut;
  String speRut;
  String stsRut;

  factory Cc0752.fromJson(String str) => Cc0752.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cc0752.fromMap(Map<String, dynamic> json) => Cc0752(
        codEmp: json["cod_emp"],
        rvcRuc: json["rvc_ruc"],
        numRut: json["num_rut"],
        ctaRut: json["cta_rut"],
        fcrRut: DateTime.parse(json["fcr_rut"]),
        speRut: json["spe_rut"],
        stsRut: json["sts_rut"],
      );

  Map<String, dynamic> toMap() => {
        "cod_emp": codEmp,
        "rvc_ruc": rvcRuc,
        "num_rut": numRut,
        "cta_rut": ctaRut,
        "fcr_rut": fcrRut.toIso8601String(),
        "spe_rut": speRut,
        "sts_rut": stsRut,
      };

  @override
  bool operator ==(Object other) => other is Cc0752 && other.ctaRut == ctaRut;

  @override
  int get hashCode => super.hashCode;
}
