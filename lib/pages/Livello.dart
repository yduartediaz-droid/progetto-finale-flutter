// ============================================================
// LIVELLO.DART
// ------------------------------------------------------------
// Pagina di selezione del livello di difficoltà, mostrata DOPO
// aver premuto GIOCA dalla Home e PRIMA di entrare in Gioco.dart.
//
// Struttura:
//   1) Sfondo con gradiente (come Home/Gioco/Risultato)
//   2) Titolo
//   3) 3 bottoni di selezione (FACILE / MEDIO / DIFFICILE)
//   4) Bottone NEXT, visibile solo dopo aver scelto un livello,
//      che porta a GiocoPage
//
// NOTA: i valori usati per la difficoltà (FACILE, MEDIO,
// DIFFICILE) sono scritti IDENTICI a quelli di DifficoltaEnum
// nel backend Spring Boot, così in futuro potrai passare questo
// valore direttamente nella richiesta HTTP senza doverlo
// "tradurre" prima.
// ============================================================

import 'package:flutter/material.dart';
import 'AppColors.dart';
import 'Gioco.dart'; // <-- serve per navigare verso GiocoPage al click su NEXT

// ============================================================
// StatefulWidget: la pagina deve "ricordarsi" quale livello è
// stato selezionato, e mostrare/nascondere il bottone NEXT di
// conseguenza — esattamente lo stesso schema già visto in
// Gioco.dart con rispostaSelezionata.
// ============================================================
class LivelloPage extends StatefulWidget {
  const LivelloPage({super.key});

  @override
  State<LivelloPage> createState() => _LivelloPageState();
}

class _LivelloPageState extends State<LivelloPage> {
  // Nessun livello selezionato all'inizio (null)
  String? livelloSelezionato;

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

                // --------------------------------------------
                // TITOLO
                // --------------------------------------------
                const Text(
                  'SCEGLI IL LIVELLO',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.titleText,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),

                // --------------------------------------------
                // 3 BOTTONI DI SELEZIONE LIVELLO
                // --------------------------------------------
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _LivelloButton(
                      label: 'FACILE',
                      valore: 'FACILE',
                      selezionato: livelloSelezionato == 'FACILE',
                      onTap: () {
                        setState(() {
                          livelloSelezionato = 'FACILE';
                        });
                      },
                    ),
                    const SizedBox(height: 20),

                    _LivelloButton(
                      label: 'MEDIO', // etichetta mostrata; puoi scrivere
                      // "INTERMEDIO" se preferisci, ma il
                      // valore sotto resta "MEDIO" per
                      // combaciare col backend
                      valore: 'MEDIO',
                      selezionato: livelloSelezionato == 'MEDIO',
                      onTap: () {
                        setState(() {
                          livelloSelezionato = 'MEDIO';
                        });
                      },
                    ),
                    const SizedBox(height: 20),

                    _LivelloButton(
                      label: 'DIFFICILE',
                      valore: 'DIFFICILE',
                      selezionato: livelloSelezionato == 'DIFFICILE',
                      onTap: () {
                        setState(() {
                          livelloSelezionato = 'DIFFICILE';
                        });
                      },
                    ),
                  ],
                ),

                // --------------------------------------------
                // BOTTONE START
                // --------------------------------------------
                // Visibile SOLO se è stato scelto un livello,
                // stesso schema del bottone CONFERMA in Gioco.dart
                // --------------------------------------------
                if (livelloSelezionato != null)
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonFill,
                        foregroundColor: AppColors.buttonText,
                        elevation: 10,
                        shadowColor: AppColors.buttonGlow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(
                            color: AppColors.buttonBorder,
                            width: 2,
                          ),
                        ),
                      ),
                      onPressed: () {
                        // Qui, quando servirà, potrai passare
                        // livelloSelezionato come parametro a
                        // GiocoPage (es. GiocoPage(difficolta:
                        // livelloSelezionato)), così Gioco saprà
                        // quali domande caricare dal backend in
                        // base al livello scelto.
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GiocoPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'START',
                        style: TextStyle(
                          fontSize: 18,
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

// ============================================================
// _LivelloButton
// ------------------------------------------------------------
// Widget privato per UN singolo bottone di selezione livello.
// Stile "pillola neon", che cambia colore quando è selezionato
// (stesso pattern del widget _Risposta in Gioco.dart, così la
// UI resta coerente in tutta l'app).
// ============================================================
class _LivelloButton extends StatelessWidget {
  final String label;       // testo mostrato nel bottone
  final String valore;      // valore "tecnico" (usato per il confronto)
  final bool selezionato;
  final VoidCallback onTap;

  const _LivelloButton({
    required this.label,
    required this.valore,
    required this.selezionato,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: selezionato
              ? Colors.green.withOpacity(0.4)
              : AppColors.buttonFill,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: selezionato ? Colors.green : AppColors.buttonBorder,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: selezionato
                  ? Colors.green.withOpacity(0.6)
                  : AppColors.buttonGlow.withOpacity(0.6),
              blurRadius: 16,
              spreadRadius: 1,
            ),
          ],
        ),
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
    );
  }
}