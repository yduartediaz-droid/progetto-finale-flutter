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

  void _mostraConfermaUscita() {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.75),
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 32),
          child: Container(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
            decoration: BoxDecoration(
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
                  "Se esci ora, il progresso andrà perso.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 28),

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
                      Navigator.pop(dialogContext);
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    child: const Text(
                      "ESCI",
                      style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

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
                                          : AppColors.buttonGlow.withOpacity(0.4),
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

              /// 🔥 BOTTONE CONFERMA PIÙ PICCOLO
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: SizedBox(
                  height: 46, // più basso
                  width: MediaQuery.of(context).size.width * 0.55, // più stretto
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonFill,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: AppColors.buttonFill.withOpacity(0.25),
                      disabledForegroundColor: Colors.white.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      shadowColor: AppColors.buttonGlow,
                      elevation: 10,
                      padding: const EdgeInsets.symmetric(vertical: 10), // meno padding
                    ),
                    onPressed: rispostaSelezionata == null
                        ? null
                        : () async {
                      final rispostaCorretta = domanda.risposte
                          .firstWhere((r) => r.idRisposta == rispostaSelezionata)
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
                        fontSize: 18, // testo più piccolo
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
