import 'package:flutter/material.dart';
import 'AppColors.dart';
import 'Gioco.dart';

/// Pagina dove l’utente seleziona il livello.
/// In questa versione i bottoni sono più piccoli,
/// identici alla dimensione dei bottoni della Home.
class LivelloPage extends StatefulWidget {
  const LivelloPage({super.key});

  @override
  State<LivelloPage> createState() => _LivelloPageState();
}

class _LivelloPageState extends State<LivelloPage> {
  // Qui salviamo il livello selezionato (FACILE, MEDIO, DIFFICILE)
  String? livelloSelezionato;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Sfondo con il gradiente neon
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // 🔙 FRECCIA INDIETRO
              // Permette di tornare alla pagina precedente
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white, size: 32),
                  splashColor: Colors.white,
                  highlightColor: Colors.white.withOpacity(0.3),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              const SizedBox(height: 10),

              // 🔠 TITOLO DELLA PAGINA
              // Ridotto leggermente per evitare scavalcamenti
              const Text(
                "Seleziona il livello",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32, // più piccolo per stare bene su tutti i telefoni
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              // ⭐ BOTTONI NEON PIÙ PICCOLI (come la Home)
              // FACILE
              _NeonButton(
                label: "FACILE",
                selected: livelloSelezionato == "FACILE",
                onTap: () {
                  // Salviamo il livello selezionato
                  setState(() => livelloSelezionato = "FACILE");

                  // Apriamo la pagina del gioco con il livello scelto
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GiocoPage(livello: "FACILE"),
                    ),
                  );
                },
              ),

              // MEDIO
              _NeonButton(
                label: "MEDIO",
                selected: livelloSelezionato == "MEDIO",
                onTap: () {
                  setState(() => livelloSelezionato = "MEDIO");

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GiocoPage(livello: "MEDIO"),
                    ),
                  );
                },
              ),

              // DIFFICILE
              _NeonButton(
                label: "DIFFICILE",
                selected: livelloSelezionato == "DIFFICILE",
                onTap: () {
                  setState(() => livelloSelezionato = "DIFFICILE");

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GiocoPage(livello: "DIFFICILE"),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// ⭐ BOTTONI NEON PIÙ PICCOLI (identici alla Home)
/// ------------------------------------------------------------
/// Questo widget crea un bottone neon con glow.
/// È identico ai bottoni della Home, ma con dimensioni ridotte.
class _NeonButton extends StatelessWidget {
  final String label;      // Testo del bottone (FACILE, MEDIO, DIFFICILE)
  final bool selected;     // Se il bottone è selezionato cambia colore
  final VoidCallback onTap; // Funzione chiamata quando premi il bottone

  const _NeonButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,   // 🔥 larghezza ridotta (come i bottoni della Home)
      height: 56,   // 🔥 altezza ridotta (come i bottoni della Home)
      margin: const EdgeInsets.symmetric(vertical: 10),

      // Stile neon del bottone
      decoration: BoxDecoration(
        color: AppColors.buttonFill,
        borderRadius: BorderRadius.circular(30),

        // Bordo che diventa ciano quando selezionato
        border: Border.all(
          color: selected ? Colors.cyanAccent : AppColors.buttonBorder,
          width: 2,
        ),

        // Glow neon
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

      // InkWell permette l’effetto “tap”
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),

        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 18, // 🔥 testo più piccolo
              fontWeight: FontWeight.bold,
              color: selected ? Colors.cyanAccent : Colors.white,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}
