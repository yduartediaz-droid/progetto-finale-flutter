class Risposta {
  final int idRisposta;
  final String testo;
  final bool corretta;

  Risposta({
    required this.idRisposta,
    required this.testo,
    required this.corretta,
  });

  factory Risposta.fromJson(Map<String, dynamic> json) {
    return Risposta(
      idRisposta: json['idRisposta'] ?? 0,
      testo: json['testo'] ?? "",
      corretta: json['corretta'] ?? false,
    );
  }
}
