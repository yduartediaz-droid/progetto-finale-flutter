// ============================================================
// GIOCO.DART
// ------------------------------------------------------------
// Questa pagina mostra una domanda del quiz con 4 risposte.
// Quando selezioni una risposta, il bottone "CONFERMA" appare.
// Le risposte sono disposte in coppia (2 per riga).
//
// Al click su CONFERMA, la risposta scelta viene confrontata con
// quella corretta, e si apre RisultatoPage passando l'esito
// (vittoria/sconfitta).
// ============================================================

import 'package:flutter/material.dart';
import 'AppColors.dart';
import 'Risultato.dart'; // <-- import aggiunto per collegare la pagina Risultato

// ============================================================
// StatefulWidget
// ------------------------------------------------------------
// Usiamo uno StatefulWidget perché la pagina deve CAMBIARE
// quando l'utente seleziona una risposta.
// Un StatelessWidget NON potrebbe aggiornare la grafica.
// ============================================================
class GiocoPage extends StatefulWidget {
  const GiocoPage({super.key});

  @override
  State<GiocoPage> createState() => _GiocoPageState();
}

class _GiocoPageState extends State<GiocoPage> {
  // ============================================================
  // Variabile che memorizza la risposta selezionata
  // ------------------------------------------------------------
  // All'inizio è null (nessuna risposta scelta).
  // Quando l'utente tocca un bottone, questa variabile cambia.
  // ============================================================
  String? rispostaSelezionata;

  // ============================================================
  // Risposta corretta per la domanda attuale
  // ------------------------------------------------------------
  // Per ora scritta a mano (dati finti), coerente con la domanda
  // fissa "Qual è la capitale dell'Irlanda?" qui sotto.
  // Quando collegherete il backend, questo valore arriverà dai
  // dati veri della domanda (DomandaEntity -> risposta con
  // corretta = true), invece di essere scritto a mano qui.
  // ============================================================
  final String rispostaCorretta = "Dublino";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Il Container occupa tutto lo schermo
        width: double.infinity,
        height: double.infinity,

        // Sfondo neon preso da AppColors
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),

        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),

            // Colonna principale della pagina
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // ------------------------------------------------------------
                // TITOLO DELLA PAGINA
                // ------------------------------------------------------------
                const Text(
                  "DOMANDA",
                  style: TextStyle(
                    color: AppColors.titleText,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                // ------------------------------------------------------------
                // INDICATORE DI PROGRESSO
                // ------------------------------------------------------------
                const Text(
                  "Domanda 1 di 10",
                  style: TextStyle(
                    color: AppColors.buttonText,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 24),

                // ------------------------------------------------------------
                // TESTO DELLA DOMANDA
                // ------------------------------------------------------------
                const Text(
                  "Qual è la capitale dell’Irlanda?",
                  style: TextStyle(
                    color: AppColors.titleText,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 32),

                // ============================================================
                // RISPOSTE IN COPPIA (2 per riga)
                // ============================================================

                Row(
                  children: [
                    // Risposta 1
                    Expanded(
                      child: _Risposta(
                        testo: "Londra",
                        selezionata: rispostaSelezionata == "Londra",
                        onTap: () {
                          // Aggiorniamo la risposta selezionata
                          setState(() {
                            rispostaSelezionata = "Londra";
                          });
                        },
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Risposta 2
                    Expanded(
                      child: _Risposta(
                        testo: "Edimburgo",
                        selezionata: rispostaSelezionata == "Edimburgo",
                        onTap: () {
                          setState(() {
                            rispostaSelezionata = "Edimburgo";
                          });
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    // Risposta 3
                    Expanded(
                      child: _Risposta(
                        testo: "Dublino",
                        selezionata: rispostaSelezionata == "Dublino",
                        onTap: () {
                          setState(() {
                            rispostaSelezionata = "Dublino";
                          });
                        },
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Risposta 4
                    Expanded(
                      child: _Risposta(
                        testo: "Parigi",
                        selezionata: rispostaSelezionata == "Parigi",
                        onTap: () {
                          setState(() {
                            rispostaSelezionata = "Parigi";
                          });
                        },
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                // ============================================================
                // BOTTONE CONFERMA
                // ------------------------------------------------------------
                // Appare SOLO quando l'utente ha selezionato una risposta.
                // Se rispostaSelezionata è null → il bottone NON viene mostrato.
                // ============================================================
                if (rispostaSelezionata != null)
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

                      // --------------------------------------------------------
                      // MODIFICATO: prima faceva solo un debugPrint.
                      // Ora confrontiamo la risposta scelta con quella corretta,
                      // e navighiamo verso RisultatoPage passando l'esito.
                      // --------------------------------------------------------
                      onPressed: () {
                        // true se l'utente ha scelto la risposta giusta
                        final bool haVinto =
                            rispostaSelezionata == rispostaCorretta;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RisultatoPage(isWin: haVinto),
                          ),
                        );
                      },

                      child: const Text(
                        "CONFERMA",
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
// WIDGET RISPOSTA
// ------------------------------------------------------------
// Questo widget rappresenta UNA singola risposta del quiz.
// Cambia colore quando è selezionata.
// ============================================================
class _Risposta extends StatelessWidget {
  final String testo;        // Testo della risposta
  final bool selezionata;    // True se l'utente l'ha selezionata
  final VoidCallback onTap;  // Funzione chiamata quando tocchi il bottone

  const _Risposta({
    required this.testo,
    required this.selezionata,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Quando tocchi il bottone, chiamiamo onTap
      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          // Se selezionata → colore diverso
          color: selezionata
              ? Colors.green.withOpacity(0.4) // colore selezione
              : AppColors.buttonFill,         // colore normale

          borderRadius: BorderRadius.circular(20),

          border: Border.all(
            color: selezionata
                ? Colors.green // bordo selezionato
                : AppColors.buttonBorder, // bordo normale
            width: 2,
          ),

          boxShadow: [
            BoxShadow(
              color: selezionata
                  ? Colors.green.withOpacity(0.6) // glow selezionato
                  : AppColors.buttonGlow.withOpacity(0.6), // glow normale
              blurRadius: 16,
              spreadRadius: 1,
            ),
          ],
        ),

        child: Text(
          testo,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.buttonText,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
