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
                        Text(
                          "Domanda ${indice + 1}/${domande!.length}",
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: AppColors.titleText,
                          ),
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonBorder,
                      foregroundColor: Colors.white,
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
