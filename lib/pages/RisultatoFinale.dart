import 'package:flutter/material.dart';
import 'AppColors.dart';
import 'Home.dart';
import 'Classifica.dart';
import '../storage/UserStorage.dart';
import '../services/PunteggioService.dart';

class RisultatoFinale extends StatelessWidget {
  final int risposteCorrette;
  final int totaleDomande;
  final String livello;

  const RisultatoFinale({
    super.key,
    required this.risposteCorrette,
    required this.totaleDomande,
    required this.livello,
  });

  Future<void> _salvaPunteggio() async {
    final userId = await UserStorage.getUserId();
    if (userId == null) return;

    final int punteggioFinale = risposteCorrette * 10;

    await PunteggioService.salvaPunteggio(
      idUtente: userId,
      livello: livello,
      punteggioFinale: punteggioFinale,
      risposteCorrette: risposteCorrette,
      totaleDomande: totaleDomande,
    );
  }

  @override
  Widget build(BuildContext context) {
    final int punteggioFinale = risposteCorrette * 10;

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
                const Text(
                  "RISULTATO FINALE",
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: AppColors.buttonBorder,
                    shadows: [
                      Shadow(
                        blurRadius: 20,
                        color: AppColors.buttonBorder,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                const Text(
                  "Hai risposto correttamente a:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "$risposteCorrette su $totaleDomande",
                  style: const TextStyle(
                    color: Colors.cyanAccent,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  "Punteggio: $punteggioFinale",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                  ),
                ),

                const SizedBox(height: 50),

                // 🔥 POST + HOME
                _NeonButton(
                  label: "TORNA ALLA HOME",
                  onTap: () async {
                    await _salvaPunteggio();

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const HomePage()),
                      (route) => false,
                    );
                  },
                ),

                const SizedBox(height: 20),

                // 🔥 POST + CLASSIFICA
                _NeonButton(
                  label: "VEDI CLASSIFICA",
                  onTap: () async {
                    await _salvaPunteggio();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ClassificaPage(),
                      ),
                    );
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
