import 'package:flutter/material.dart';
import '../models/domanda.dart';
import '../services/QuizService.dart';
import 'Risultato.dart';
import 'AppColors.dart';

/// Pagina del quiz.
/// Qui viene gestita la logica delle domande, risposte, avanzamento
/// e stile neon uniforme.
class GiocoPage extends StatefulWidget {
  final String livello; // livello scelto dall’utente (es. facile, medio, difficile)

  const GiocoPage({super.key, required this.livello});

  @override
  State<GiocoPage> createState() => _GiocoPageState();
}

class _GiocoPageState extends State<GiocoPage> {
  List<Domanda>? domande; // lista delle domande caricate dal backend
  int indice = 0; // indice della domanda corrente
  int? rispostaSelezionata; // id della risposta selezionata dall’utente
  int risposteCorrette = 0; // contatore risposte corrette

  @override
  void initState() {
    super.initState();
    _caricaDomande(); // carica le domande appena la pagina viene aperta
  }

  /// Carica le domande dal servizio QuizService
  Future<void> _caricaDomande() async {
    try {
      domande = await QuizService.getDomandeByLivello(widget.livello);
      setState(() {}); // aggiorna la UI
    } catch (e) {
      debugPrint("Errore nel caricamento domande: $e");
    }
  }

  /// Popup di conferma uscita dal quiz
  void _mostraConfermaUscita() {
    showDialog(
      context: context,
      barrierDismissible: true, // permette chiusura cliccando fuori
      barrierColor: Colors.black.withOpacity(0.75), // sfondo scuro
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 32),
          child: Container(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
            decoration: BoxDecoration(
              color: const Color(0xFF150826), // colore neon scuro
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.buttonBorder, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 24,
                  spreadRadius: 4,
                ),
                BoxShadow(
                  color: AppColors.buttonGlow.withOpacity(0.25),
                  blurRadius: 30,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline_rounded,
                    color: Colors.cyanAccent, size: 40),
                const SizedBox(height: 16),

                const Text(
                  "Vuoi uscire dalla partita?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Se esci ora, il progresso andrà perso.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 28),

                // Bottone ESCI
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonBorder,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 6,
                      shadowColor: AppColors.buttonGlow,
                    ),
                    onPressed: () {
                      Navigator.pop(dialogContext); // chiude popup
                      Navigator.popUntil(context, (route) => route.isFirst);
                      // torna alla home
                    },
                    child: const Text(
                      "ESCI",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Bottone continua
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text(
                    "CONTINUA A GIOCARE",
                    style: TextStyle(
                      color: Colors.cyanAccent,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Se le domande non sono ancora state caricate → mostra caricamento
    if (domande == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final domanda = domande![indice]; // domanda corrente
    final isLastQuestion = indice == domande!.length - 1; // ultima domanda?

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient, // sfondo neon
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        /// TITOLO NEON (Domanda X/Y)
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              "Domanda ${indice + 1}/${domande!.length}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: Colors.cyanAccent,
                                    blurRadius: 20,
                                  )
                                ],
                              ),
                            ),

                            // Bottone X per uscire
                            Positioned(
                              right: 0,
                              child: IconButton(
                                icon: const Icon(Icons.close,
                                    color: Colors.white),
                                onPressed: _mostraConfermaUscita,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        /// Testo della domanda
                        Text(
                          domanda.testo,
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            height: 1.3,
                          ),
                        ),

                        const SizedBox(height: 40),

                        /// RISPOSTE — stile neon
                        Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: domanda.risposte.map((r) {
                            final selected =
                                rispostaSelezionata == r.idRisposta;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  rispostaSelezionata = r.idRisposta;
                                });
                              },
                              child: Container(
                                width:
                                (MediaQuery.of(context).size.width - 80) /
                                    2, // 2 colonne
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.buttonFill,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: selected
                                        ? Colors.cyanAccent
                                        : AppColors.buttonBorder,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: selected
                                          ? Colors.cyanAccent.withOpacity(0.6)
                                          : AppColors.buttonGlow
                                          .withOpacity(0.4),
                                      blurRadius: 20,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  r.testo,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: selected
                                        ? Colors.cyanAccent
                                        : AppColors.buttonText,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),

              /// PULSANTE CONFERMA — stile neon
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: SizedBox(
                  height: 56,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonBorder,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor:
                      AppColors.buttonBorder.withOpacity(0.25),
                      disabledForegroundColor:
                      Colors.white.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      shadowColor: AppColors.buttonGlow,
                      elevation: 10,
                    ),

                    /// Logica del pulsante CONFERMA
                    onPressed: rispostaSelezionata == null
                        ? null // disabilitato se non selezioni una risposta
                        : () async {
                      // Controlla se la risposta è corretta
                      final rispostaCorretta = domanda.risposte
                          .firstWhere((r) =>
                      r.idRisposta == rispostaSelezionata)
                          .corretta;

                      if (rispostaCorretta) {
                        risposteCorrette++; // incrementa punteggio
                      }

                      // Vai alla pagina risultato
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RisultatoPage(
                            isWin: rispostaCorretta,
                            livello: widget.livello,
                            curiosita: domanda.curiosita,
                            isLastQuestion: isLastQuestion,
                            risposteCorrette: risposteCorrette,
                            totaleDomande: domande!.length,
                          ),
                        ),
                      );

                      // Se l’utente torna e NON è l’ultima domanda → passa alla successiva
                      if (result == true && !isLastQuestion) {
                        setState(() {
                          indice++;
                          rispostaSelezionata = null; // reset selezione
                        });
                      }
                    },

                    child: const Text(
                      "CONFERMA",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
