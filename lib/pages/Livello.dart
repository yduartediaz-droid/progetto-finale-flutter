// ============================================================
// LIVELLO.DART
// ------------------------------------------------------------
// Pagina dove l'utente sceglie il livello di difficoltà
// (FACILE / MEDIO / DIFFICILE) prima di iniziare a giocare.
//
// COMPORTAMENTO:
// Toccare FACILE / MEDIO / DIFFICILE fa SOLO la selezione (il
// bottone si illumina, ma non si cambia ancora pagina). Compare
// poi un bottone CONFERMA, spinto in fondo alla pagina, visibile
// SOLO dopo aver scelto un livello. Solo premendo CONFERMA si
// apre GiocoPage col livello scelto.
//
// Questo pattern (seleziona -> poi conferma con un bottone
// dedicato) è lo stesso già usato in Gioco.dart per le risposte.
// ============================================================

import 'package:flutter/material.dart';
import 'AppColors.dart';
import 'Gioco.dart';

/// Pagina dove l'utente seleziona il livello.
/// In questa versione i bottoni sono più piccoli,
/// identici alla dimensione dei bottoni della Home.
class LivelloPage extends StatefulWidget {
  const LivelloPage({super.key});

  @override
  State<LivelloPage> createState() => _LivelloPageState();
}

// ============================================================
// StatefulWidget: la pagina deve "ricordarsi" quale livello è
// stato scelto (per illuminare il bottone giusto e per decidere
// se mostrare o no il bottone CONFERMA), quindi serve uno stato
// interno che può cambiare — stesso schema già visto in
// Gioco.dart con rispostaSelezionata.
// ============================================================
class _LivelloPageState extends State<LivelloPage> {
  // Qui salviamo il livello selezionato (FACILE, MEDIO, DIFFICILE).
  // Vale null finché l'utente non ha ancora scelto nulla.
  String? livelloSelezionato;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Sfondo con il gradiente neon (uguale a tutte le altre pagine)
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // ------------------------------------------------
              // FRECCIA INDIETRO
              // ------------------------------------------------
              // Permette di tornare alla pagina precedente (Home)
              // senza aver scelto nessun livello.
              // ------------------------------------------------
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

              // ------------------------------------------------
              // TITOLO DELLA PAGINA
              // ------------------------------------------------
              const Text(
                "Seleziona il livello",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              // ------------------------------------------------
              // BOTTONI DI SELEZIONE LIVELLO (FACILE / MEDIO / DIFFICILE)
              // ------------------------------------------------
              // onTap fa SOLO setState per salvare la scelta. La
              // navigazione vera e propria avviene SOLO nel bottone
              // CONFERMA più sotto, non qui.
              // ------------------------------------------------

              // FACILE
              _NeonButton(
                label: "FACILE",
                selected: livelloSelezionato == "FACILE",
                onTap: () {
                  // Salviamo semplicemente quale livello è stato
                  // toccato. setState dice a Flutter "ridisegna",
                  // così il bottone FACILE si illumina subito.
                  setState(() => livelloSelezionato = "FACILE");
                },
              ),

              // MEDIO
              _NeonButton(
                label: "MEDIO",
                selected: livelloSelezionato == "MEDIO",
                onTap: () {
                  setState(() => livelloSelezionato = "MEDIO");
                },
              ),

              // DIFFICILE
              _NeonButton(
                label: "DIFFICILE",
                selected: livelloSelezionato == "DIFFICILE",
                onTap: () {
                  setState(() => livelloSelezionato = "DIFFICILE");
                },
              ),

              // ------------------------------------------------
              // SPACER
              // ------------------------------------------------
              // Widget "elastico": si espande occupando TUTTO lo
              // spazio verticale rimasto nella Column, spingendo
              // tutto quello che viene scritto dopo di lui (qui,
              // il bottone CONFERMA) fino in fondo alla pagina.
              // Senza questo, CONFERMA comparirebbe subito sotto
              // DIFFICILE, appiccicato ai bottoni di livello.
              // ------------------------------------------------
              const Spacer(),

              // ------------------------------------------------
              // BOTTONE CONFERMA
              // ------------------------------------------------
              // Visibile SOLO se è stato scelto un livello (stesso
              // schema del bottone CONFERMA in Gioco.dart, che
              // appare solo dopo aver scelto una risposta).
              //
              // Se livelloSelezionato è null, questo blocco "if"
              // non produce nessun widget: è come se il bottone
              // non esistesse affatto nella pagina, finché l'utente
              // non sceglie un livello.
              // ------------------------------------------------
              if (livelloSelezionato != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: SizedBox(
                    width: 260,
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
                      // Qui, e SOLO qui, avviene la navigazione
                      // verso GiocoPage, passando il livello scelto.
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => GiocoPage(
                              livello: livelloSelezionato!,
                              // Il punto esclamativo (!) dice a Dart
                              // "sono sicuro che non è null qui" —
                              // possiamo usarlo con tranquillità
                              // perché questo bottone compare SOLO
                              // quando livelloSelezionato è già stato
                              // impostato (grazie all'if sopra).
                            ),
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
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// _NeonButton
// ------------------------------------------------------------
// Widget privato (usato solo in questo file) che disegna UN
// singolo bottone di selezione livello, in stile "pillola neon".
// Cambia colore/bordo quando è selezionato (proprietà "selected").
//
// Stesso motivo di sempre per farne un widget a parte: evitare
// di ripetere lo stesso identico codice di stile 3 volte (una
// per FACILE, una per MEDIO, una per DIFFICILE).
// ============================================================
class _NeonButton extends StatelessWidget {
  final String label;       // Testo del bottone (FACILE, MEDIO, DIFFICILE)
  final bool selected;      // Se il bottone è quello attualmente scelto
  final VoidCallback onTap; // Funzione chiamata quando premi il bottone

  const _NeonButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,   // stessa larghezza dei bottoni della Home
      height: 56,   // stessa altezza dei bottoni della Home
      margin: const EdgeInsets.symmetric(vertical: 10),

      // Stile neon del bottone
      decoration: BoxDecoration(
        color: AppColors.buttonFill,
        borderRadius: BorderRadius.circular(30),

        // Bordo che diventa ciano acceso quando il bottone è selezionato,
        // altrimenti resta il ciano "normale" definito in AppColors
        border: Border.all(
          color: selected ? Colors.cyanAccent : AppColors.buttonBorder,
          width: 2,
        ),

        // Glow (bagliore) attorno al bottone: più intenso se selezionato
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

      // InkWell aggiunge l'effetto "ripple" (cerchio che si espande)
      // al tocco, e gestisce onTap
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),

        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              // Anche il testo cambia colore quando selezionato,
              // per rinforzare visivamente la scelta fatta
              color: selected ? Colors.cyanAccent : Colors.white,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}