import 'package:flutter/material.dart';
import 'AppColors.dart';
import 'RisultatoFinale.dart';

class RisultatoPage extends StatelessWidget {
  final bool isWin;
  final String livello;
  final String curiosita;
  final bool isLastQuestion;
  final int risposteCorrette;
  final int totaleDomande;

  const RisultatoPage({
    super.key,
    required this.isWin,
    required this.livello,
    required this.curiosita,
    required this.isLastQuestion,
    required this.risposteCorrette,
    required this.totaleDomande,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // TITOLO CORRETTA / SBAGLIATA
                Text(
                  isWin ? "RISPOSTA CORRETTA!" : "RISPOSTA SBAGLIATA!",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: isWin ? AppColors.buttonBorder : Colors.redAccent,
                    shadows: [
                      Shadow(
                        blurRadius: 20,
                        color: isWin ? AppColors.buttonBorder : Colors.redAccent,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // BOTTONE CURIOSITÀ
                _NeonButton(
                  label: "CURIOSITÀ",
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        backgroundColor: Colors.black.withOpacity(0.85),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: const Text(
                          "Curiosità",
                          style: TextStyle(
                            color: Colors.cyanAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Text(
                          curiosita,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            height: 1.4,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // SE NON È L’ULTIMA DOMANDA → MOSTRA "PROSSIMA DOMANDA"
                if (!isLastQuestion)
                  _NeonButton(
                    label: "PROSSIMA DOMANDA",
                    onTap: () {
                      Navigator.pop(context, true); // torna alla GiocoPage
                    },
                  ),

                // SE È L’ULTIMA DOMANDA → MOSTRA SOLO "FINE QUIZ"
                if (isLastQuestion) ...[
                  const SizedBox(height: 40),

                  _NeonButton(
                    label: "FINE QUIZ",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RisultatoFinale(
                            risposteCorrette: risposteCorrette,
                            totaleDomande: totaleDomande,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NeonButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _NeonButton({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.buttonFill,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppColors.buttonBorder,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.buttonGlow.withOpacity(0.6),
            blurRadius: 16,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Center(
              child: Text(
                label,
                style: const TextStyle(
                  color: AppColors.buttonText,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
