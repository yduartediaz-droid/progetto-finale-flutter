// ============================================================
// RISULTATO.DART
// ------------------------------------------------------------
// Schermata che mostra il risultato del quiz:
//   - WIN  -> messaggio di vittoria
//   - LOSE -> messaggio di sconfitta
//
// Struttura generale (come Home.dart):
//   1) Sfondo con gradiente (AppColors.backgroundGradient)
//   2) Titolo + sottotitolo centrati
//   3) Pulsante neon (stile simile ai menu della Home)
//
// Usa SOLO i colori già presenti in AppColors.dart.
// ============================================================

import 'package:flutter/material.dart';
import 'AppColors.dart';

class RisultatoPage extends StatelessWidget {
  final bool isWin;

  const RisultatoPage({super.key, required this.isWin});

  @override
  Widget build(BuildContext context) {
    // ------------------------------------------------------------
    // 1) Variabili dinamiche in base al risultato
    // ------------------------------------------------------------
    final String title = isWin ? "CONGRATS!" : "OH NO!";
    final String subtitle = isWin ? "YOU WIN" : "YOU LOST";
    final String buttonText = isWin ? "NEXT" : "TRY AGAIN";

    // Colori neon già presenti in AppColors
    final Color borderColor = AppColors.buttonBorder; // ciano neon
    final Color glowColor = AppColors.buttonGlow;     // magenta neon

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        // --------------------------------------------------------
        // 2) SFONDO (stesso stile della Home)
        // --------------------------------------------------------
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),

        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                // --------------------------------------------------------
                // 3) TITOLO + SOTTOTITOLO (centrati)
                // --------------------------------------------------------
                Column(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: borderColor,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        shadows: [
                          Shadow(color: borderColor, blurRadius: 25),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    Text(
                      subtitle,
                      style: TextStyle(
                        color: glowColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(color: glowColor, blurRadius: 20),
                        ],
                      ),
                    ),
                  ],
                ),

                // --------------------------------------------------------
                // 4) PULSANTE NEON (stile identico ai bottoni della Home)
                // --------------------------------------------------------
                _ResultButton(
                  label: buttonText,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// _ResultButton
// ------------------------------------------------------------
// Stesso stile dei pulsanti della Home:
//   - forma a pillola
//   - bordo neon ciano
//   - glow magenta
//   - ripple al tocco
// ============================================================
class _ResultButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _ResultButton({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
            onTap: onPressed,
            child: Center(
              child: Text(
                label,
                style: const TextStyle(
                  color: AppColors.buttonText,
                  fontSize: 16,
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
