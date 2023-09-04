import 'dart:convert';

class Cc0751 {
  Cc0751({
    required this.codEmp,
    required this.rvcRuc,
    required this.numRut,
    required this.fecRut,
    required this.obsRut,
    required this.ndcRut,
    required this.vtaRut,
    required this.recRut,
    required this.stsRut,
  });

  String codEmp;
  String rvcRuc;
  String numRut;
  DateTime fecRut;
  String obsRut;
  String ndcRut;
  double vtaRut;
  double recRut;
  String stsRut;

  factory Cc0751.fromJson(String str) => Cc0751.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cc0751.fromMap(Map<String, dynamic> json) => Cc0751(
        codEmp: json["cod_emp"],
        rvcRuc: json["rvc_ruc"],
        numRut: json["num_rut"],
        fecRut: DateTime.parse(json["fec_rut"]),
        obsRut: json["obs_rut"],
        ndcRut: json["ndc_rut"],
        vtaRut: json["vta_rut"].toDouble(),
        recRut: json["rec_rut"].toDouble(),
        stsRut: json["sts_rut"],
      );

  Map<String, dynamic> toMap() => {
        "cod_emp": codEmp,
        "rvc_ruc": rvcRuc,
        "num_rut": numRut,
        "fec_rut": fecRut.toIso8601String(),
        "obs_rut": obsRut,
        "ndc_rut": ndcRut,
        "vta_rut": vtaRut,
        "rec_rut": recRut,
        "sts_rut": stsRut,
      };
}
