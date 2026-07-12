class Risposta {
  final int idRispostaPk;
  final String testo;
  final bool corretta;

  Risposta({
    required this.idRispostaPk,
    required this.testo,
    required this.corretta,
  });

  factory Risposta.fromJson(Map<String, dynamic> json) {
    return Risposta(
      idRispostaPk: json['idRispostaPk'],
      testo: json['testo'],
      corretta: json['corretta'],
    );
  }
}