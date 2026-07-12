import 'risposta.dart';


class Domanda {
  final int idDomandaPk;
  final String testo;
  final String materia;
  final String difficolta;
  final String curiosita;
  final List<Risposta> risposte;

  Domanda({
    required this.idDomandaPk,
    required this.testo,
    required this.materia,
    required this.difficolta,
    required this.curiosita,
    required this.risposte,
  });

  factory Domanda.fromJson(Map<String, dynamic> json) {
    return Domanda(
      idDomandaPk: json['idDomandaPk'],
      testo: json['testo'],
      materia: json['materia'],
      difficolta: json['difficolta'],
      curiosita: json['curiosita'],
      risposte: (json['risposte'] as List)
          .map((r) => Risposta.fromJson(r))
          .toList(),
    );
  }
}