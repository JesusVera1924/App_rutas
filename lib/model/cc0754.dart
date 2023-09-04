import 'dart:convert';

class Cc0754 {
  Cc0754({
    required this.codEmp,
    required this.rvcRut,
    required this.fecRut,
    required this.numRut,
    required this.ctaRut,
    required this.tvcRut,
    required this.terRut,
    required this.covRut,
    required this.obsRut,
    required this.fvsRut,
    required this.notRut,
    required this.ucmRut,
    required this.fcmRut,
    required this.fexRut,
    required this.nexRut,
    required this.speRut,
    required this.s1sRut,
    required this.s2SRut,
    required this.seCRut,
  });

  String codEmp;
  String rvcRut;
  String fecRut;
  String numRut;
  String ctaRut;
  String tvcRut;
  String terRut;
  String covRut;
  String obsRut;
  String fvsRut;
  String notRut;
  String ucmRut;
  String fcmRut;
  String fexRut;
  String nexRut;
  String speRut;
  String s1sRut;
  String s2SRut;
  String seCRut;

  factory Cc0754.fromJson(String str) => Cc0754.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cc0754.fromMap(Map<String, dynamic> json) => Cc0754(
        codEmp: json["cod_emp"],
        rvcRut: json["rvc_rut"],
        fecRut: json["fec_rut"],
        numRut: json["num_rut"],
        ctaRut: json["cta_rut"],
        tvcRut: json["tvc_rut"],
        terRut: json["ter_rut"],
        covRut: json["cov_rut"],
        obsRut: json["obs_rut"],
        fvsRut: json["fvs_rut"],
        notRut: json["not_rut"],
        ucmRut: json["ucm_rut"],
        fcmRut: json["fcm_rut"],
        fexRut: json["fex_rut"],
        nexRut: json["nex_rut"],
        speRut: json["spe_rut"],
        s1sRut: json["s1s_rut"],
        s2SRut: json["s2s_rut"],
        seCRut: json["sec_rut"],
      );

  Map<String, dynamic> toMap() => {
        "cod_emp": codEmp,
        "rvc_rut": rvcRut,
        "fec_rut": fecRut,
        "num_rut": numRut,
        "cta_rut": ctaRut,
        "tvc_rut": tvcRut,
        "ter_rut": terRut,
        "cov_rut": covRut,
        "obs_rut": obsRut,
        "fvs_rut": fvsRut,
        "not_rut": notRut,
        "ucm_rut": ucmRut,
        "fcm_rut": fcmRut,
        "fex_rut": fexRut,
        "nex_rut": nexRut,
        "spe_rut": speRut,
        "s1s_rut": s1sRut,
        "s2s_rut": s2SRut,
        "sec_rut": seCRut,
      };
}
