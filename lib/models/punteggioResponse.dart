class PunteggioResponse {
  final int idPunteggio;
  final int idUtente;
  final String username;     // 🔥 AGGIUNTO
  final String livello;
  final int punteggioFinale;
  final int risposteCorrette;
  final int totaleDomande;
  final String dataQuiz;

  PunteggioResponse({
    required this.idPunteggio,
    required this.idUtente,
    required this.username,
    required this.livello,
    required this.punteggioFinale,
    required this.risposteCorrette,
    required this.totaleDomande,
    required this.dataQuiz,
  });

  factory PunteggioResponse.fromJson(Map<String, dynamic> json) {
    return PunteggioResponse(
      idPunteggio: json["idPunteggio"],
      idUtente: json["idUtente"],
      username: json["username"],   // 🔥 AGGIUNTO
      livello: json["livello"],
      punteggioFinale: json["punteggioFinale"],
      risposteCorrette: json["risposteCorrette"],
      totaleDomande: json["totaleDomande"],
      dataQuiz: json["dataQuiz"],
    );
  }
}
