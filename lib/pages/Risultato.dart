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

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      const Text(
                        "CURIOSITÀ",
                        style: TextStyle(
                          color: Colors.cyanAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        curiosita,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                if (!isLastQuestion)
                  _NeonButton(
                    label: "PROSSIMA DOMANDA",
                    onTap: () {
                      Navigator.pop(context, true);
                    },
                  ),

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
                            livello: livello, // 🔥 AGGIUNTO
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
