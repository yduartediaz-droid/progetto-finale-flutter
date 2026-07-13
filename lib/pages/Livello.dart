import 'package:flutter/material.dart';
import 'AppColors.dart';
import 'Gioco.dart';
import 'PageHeader.dart';

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),

                // TITOLO + FRECCIA INDIETRO
                const PageHeader(title: "Seleziona il livello"),

                const SizedBox(height: 40),

                // FACILE
                _LivelloButton(
                  label: "FACILE",
                  selected: livelloSelezionato == "FACILE",
                  onTap: () {
                    setState(() => livelloSelezionato = "FACILE");
                  },
                ),

                // MEDIO
                _LivelloButton(
                  label: "MEDIO",
                  selected: livelloSelezionato == "MEDIO",
                  onTap: () {
                    setState(() => livelloSelezionato = "MEDIO");
                  },
                ),

                // DIFFICILE
                _LivelloButton(
                  label: "DIFFICILE",
                  selected: livelloSelezionato == "DIFFICILE",
                  onTap: () {
                    setState(() => livelloSelezionato = "DIFFICILE");
                  },
                ),

                const Spacer(),

                // START BUTTON
                if (livelloSelezionato != null)
                  SizedBox(
                    height: 56,
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => GiocoPage(
                              livello: livelloSelezionato!,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "START",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LivelloButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _LivelloButton({
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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: selected ? Colors.cyanAccent : AppColors.buttonText,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}