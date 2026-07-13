import 'package:flutter/material.dart';
import '../models/domanda.dart';
import '../services/QuizService.dart';
import 'Risultato.dart';
import 'AppColors.dart';

class GiocoPage extends StatefulWidget {
  final String livello;

  const GiocoPage({super.key, required this.livello});

  @override
  State<GiocoPage> createState() => _GiocoPageState();
}

class _GiocoPageState extends State<GiocoPage> {
  List<Domanda>? domande;
  int indice = 0;
  int? rispostaSelezionata;
  int risposteCorrette = 0;

  @override
  void initState() {
    super.initState();
    _caricaDomande();
  }

  Future<void> _caricaDomande() async {
    try {
      domande = await QuizService.getDomandeByLivello(widget.livello);
      setState(() {});
    } catch (e) {
      debugPrint("Errore nel caricamento domande: $e");
    }
  }

  // ------------------------------------------------------------
  // Popup di conferma uscita: mostrato quando l'utente tocca la X.
  // Due opzioni:
  //  - "CONTINUA A GIOCARE" -> chiude il popup, resta in partita
  //  - "ESCI"               -> torna sempre alla Home
  // ------------------------------------------------------------
  void _mostraConfermaUscita() {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.75), // sfondo dietro al popup più scuro
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 32),
          child: Container(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
            decoration: BoxDecoration(
              // Sfondo scuro pieno (quasi nero/viola), non trasparente come i bottoni
              color: const Color(0xFF150826),
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
                const Icon(Icons.error_outline_rounded, color: Colors.cyanAccent, size: 40),
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
                  "Se esci ora, il progresso di questa partita andrà perso.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 28),

                // ESCI -> bottone pieno, azione principale del popup
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
                      Navigator.pop(dialogContext); // chiude il popup
                      Navigator.popUntil(context, (route) => route.isFirst); // torna alla Home
                    },
                    child: const Text(
                      "ESCI",
                      style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // CONTINUA A GIOCARE -> azione secondaria, solo testo
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext), // chiude solo il popup
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
    if (domande == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final domanda = domande![indice];
    final isLastQuestion = indice == domande!.length - 1;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // ------------------------------------------------
                        // RIGA SUPERIORE: contatore domanda + pulsante ESCI
                        // ------------------------------------------------
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              "Domanda ${indice + 1}/${domande!.length}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: AppColors.titleText,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              child: IconButton(
                                icon: const Icon(Icons.close, color: Colors.white),
                                onPressed: _mostraConfermaUscita,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        Text(
                          domanda.testo,
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            height: 1.3,
                          ),
                        ),

                        const SizedBox(height: 40),

                        Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: domanda.risposte.map((r) {
                            final selected = rispostaSelezionata == r.idRisposta;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  rispostaSelezionata = r.idRisposta;
                                });
                              },
                              child: Container(
                                width: (MediaQuery.of(context).size.width - 80) / 2,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.buttonFill,
                                  borderRadius: BorderRadius.circular(20),
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
                                          : AppColors.buttonGlow.withOpacity(0.4),
                                      blurRadius: 14,
                                      spreadRadius: 1,
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
                                    fontWeight: FontWeight.w600,
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

              // 🔥 PULSANTE FISSO IN BASSO — niente spazio bianco
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: SizedBox(
                  height: 56,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                  /*  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonBorder,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      shadowColor: AppColors.buttonGlow,
                      elevation: 10,
                    ),*/
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonBorder,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: AppColors.buttonBorder.withOpacity(0.25),
                      disabledForegroundColor: Colors.white.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      shadowColor: AppColors.buttonGlow,
                      elevation: 10,
                    ),
                    onPressed: rispostaSelezionata == null
                        ? null
                        : () async {
                      final rispostaCorretta = domanda.risposte
                          .firstWhere(
                            (r) => r.idRisposta == rispostaSelezionata,
                      )
                          .corretta;

                      if (rispostaCorretta) {
                        risposteCorrette++;
                      }

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

                      if (result == true && !isLastQuestion) {
                        setState(() {
                          indice++;
                          rispostaSelezionata = null;
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