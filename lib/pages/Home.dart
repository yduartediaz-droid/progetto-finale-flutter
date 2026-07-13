// ============================================================
// HOME.DART - VERSIONE CON BOTTONI PIÙ PICCOLI E CENTRATI
// ============================================================

import 'Regole.dart';
import 'Livello.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'Classifica.dart';
import 'Gioco.dart';
import 'package:flutter/material.dart';
import 'AppColors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                // ------------------------------------------------------------
                // LOGO + TITOLO
                // ------------------------------------------------------------
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/LogoApp.svg',
                      width: 100,
                      height: 100,
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      'Brain Snack',
                      style: TextStyle(
                        color: AppColors.titleText,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),

                // ------------------------------------------------------------
                // MENU BOTTONI (CENTRATI E PIÙ PICCOLI)
                // ------------------------------------------------------------
                Center( // <--- questo centra la colonna dei bottoni
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _MenuButton(
                        label: 'GIOCA',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LivelloPage()),
                          );
                        },
                      ),

                      const SizedBox(height: 20),

                      _MenuButton(
                        label: 'CLASSIFICA',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ClassificaPage()),
                          );
                        },
                      ),

                      const SizedBox(height: 20),

                      _MenuButton(
                        label: 'REGOLE',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegolePage()),
                          );
                        },
                      ),
                    ],
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

// ============================================================
// _MenuButton - VERSIONE CON LARGHEZZA RIDOTTA
// ============================================================

class _MenuButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _MenuButton({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260, // <--- LARGHEZZA RIDOTTA (prima era double.infinity)
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
