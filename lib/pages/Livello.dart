import 'package:flutter/material.dart';
import 'AppColors.dart';
import 'Gioco.dart';

class LivelloPage extends StatefulWidget {
  const LivelloPage({super.key});

  @override
  State<LivelloPage> createState() => _LivelloPageState();
}

class _LivelloPageState extends State<LivelloPage> {
  String? livelloSelezionato;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // 🔙 FRECCIA INDIETRO
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

              // 🔠 TITOLO IDENTICO ALLA HOME
              const Text(
                "Seleziona il livello",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              // ⭐ BOTTONI NEON IDENTICI ALLA HOME
              _NeonButton(
                label: "FACILE",
                selected: livelloSelezionato == "FACILE",
                onTap: () {
                  setState(() => livelloSelezionato = "FACILE");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GiocoPage(livello: "FACILE"),
                    ),
                  );
                },
              ),

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

// ------------------------------------------------------------
// ⭐ BOTTONI NEON IDENTICI ALLA HOME
// ------------------------------------------------------------
class _NeonButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NeonButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.buttonFill,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: selected ? Colors.cyanAccent : AppColors.buttonBorder,
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
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: selected ? Colors.cyanAccent : Colors.white,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
