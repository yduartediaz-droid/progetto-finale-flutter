import 'risposta.dart';

class Domanda {
  final int idDomanda;
  final String testo;
  final String materia;
  final String difficolta;
  final String curiosita;
  final List<Risposta> risposte;

  Domanda({
    required this.idDomanda,
    required this.testo,
    required this.materia,
    required this.difficolta,
    required this.curiosita,
    required this.risposte,
  });

  factory Domanda.fromJson(Map<String, dynamic> json) {
    return Domanda(
      idDomanda: json['idDomanda'] ?? 0,
      testo: json['testo'] ?? "",
      materia: json['materia'] ?? "",
      difficolta: json['difficolta'] ?? "",
      curiosita: json['curiosita'] ?? "",
      risposte: (json['risposte'] as List<dynamic>? ?? [])
          .map((r) => Risposta.fromJson(r))
          .toList(),
    );
  }
}
