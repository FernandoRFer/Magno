class MtbModel {
  late Mtb mtb;

  MtbModel({required this.mtb});

  MtbModel.fromJson(Map<String, dynamic> json) {
    mtb = Mtb.fromJson(json['mtb']);
  }
}

class Mtb {
  late String codret;
  late String msgret;
  late List<Retornapopupteste> retornapopupteste;

  Mtb(
      {required this.codret,
      required this.msgret,
      required this.retornapopupteste});

  Mtb.fromJson(Map<String, dynamic> json) {
    codret = json['codret'];
    msgret = json['msgret'];
    if (json['retornapopupteste'] != null) {
      retornapopupteste = List<Retornapopupteste>.empty(growable: true);
      json['retornapopupteste'].forEach((v) {
        retornapopupteste.add(Retornapopupteste.fromJson(v));
      });
    }
  }
}

class Retornapopupteste {
  late String pOPUP;

  Retornapopupteste({required this.pOPUP});

  Retornapopupteste.fromJson(Map<String, dynamic> json) {
    pOPUP = json['POPUP'];
  }
}
