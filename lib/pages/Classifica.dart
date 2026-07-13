// ============================================================
// CLASSIFICA.DART
// ------------------------------------------------------------
// Ora la classifica è divisa per livello: l'utente sceglie
// FACILE / MEDIO / DIFFICILE con i 3 bottoni in alto, e sotto
// vede solo i giocatori che hanno giocato a quel livello,
// ordinati dal punteggio più alto al più basso.
//
// I dati sono ancora FINTI (vedi "DATI DI ESEMPIO" più sotto).
// Quando collegherai il backend Spring Boot, ogni giocatore
// dovrà arrivare già con il campo "livello" valorizzato
// (es. "FACILE", "MEDIO" o "DIFFICILE").
// ============================================================

import 'package:flutter/material.dart';
import 'AppColors.dart';
import 'PageHeader.dart';

// ------------------------------------------------------------
// MODELLO DATI
// ------------------------------------------------------------
class Giocatore {
  final String nome;
  final int punteggio;
  final String livello; // "FACILE" | "MEDIO" | "DIFFICILE"

  const Giocatore({
    required this.nome,
    required this.punteggio,
    required this.livello,
  });
}

// ------------------------------------------------------------
// Ora StatefulWidget perché dobbiamo "ricordare" quale livello
// è selezionato (parte da FACILE) e aggiornare la lista quando
// l'utente tocca un altro bottone.
// ------------------------------------------------------------
class ClassificaPage extends StatefulWidget {
  const ClassificaPage({super.key});

  @override
  State<ClassificaPage> createState() => _ClassificaPageState();
}

class _ClassificaPageState extends State<ClassificaPage> {
  String livelloSelezionato = "FACILE"; // livello mostrato di default all'apertura

  // ----------------------------------------------------------
  // DATI (per ora vuoti: nessun nome finto)
  // ----------------------------------------------------------
  // Quando collegherai il backend Spring Boot, questa lista
  // andrà sostituita con i giocatori veri presi dall'API
  // (ognuno con nome, punteggio e livello).
  // ----------------------------------------------------------
  static const List<Giocatore> _datiFinti = [];

  @override
  Widget build(BuildContext context) {
    // Filtra solo i giocatori del livello selezionato, poi ordina
    // dal punteggio più alto al più basso.
    final List<Giocatore> classificaFiltrata = _datiFinti
        .where((g) => g.livello == livelloSelezionato)
        .toList()
      ..sort((a, b) => b.punteggio - a.punteggio);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ------------------------------------------------
              // TITOLO DELLA PAGINA + FRECCIA INDIETRO
              // ------------------------------------------------
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: PageHeader(
                  title: 'CLASSIFICA',
                  fontSize: 28,
                  letterSpacing: 2,
                ),
              ),

              // ------------------------------------------------
              // 3 BOTTONI: FACILE / MEDIO / DIFFICILE
              // ------------------------------------------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: _FiltroLivelloButton(
                        label: "FACILE",
                        selected: livelloSelezionato == "FACILE",
                        onTap: () => setState(() => livelloSelezionato = "FACILE"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _FiltroLivelloButton(
                        label: "MEDIO",
                        selected: livelloSelezionato == "MEDIO",
                        onTap: () => setState(() => livelloSelezionato = "MEDIO"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _FiltroLivelloButton(
                        label: "DIFFICILE",
                        selected: livelloSelezionato == "DIFFICILE",
                        onTap: () => setState(() => livelloSelezionato = "DIFFICILE"),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ------------------------------------------------
              // LISTA DEI GIOCATORI DEL LIVELLO SELEZIONATO
              // ------------------------------------------------
              Expanded(
                child: classificaFiltrata.isEmpty
                    ? const Center(
                  child: Text(
                    "Nessun punteggio ancora registrato\nper questo livello.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                )
                    : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: classificaFiltrata.length,
                  itemBuilder: (context, index) {
                    final Giocatore giocatore = classificaFiltrata[index];
                    final int posizione = index + 1;

                    return _RigaClassifica(
                      posizione: posizione,
                      nome: giocatore.nome,
                      punteggio: giocatore.punteggio,
                    );
                  },
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
// _FiltroLivelloButton
// ------------------------------------------------------------
// Bottone piccolo "a pillola" per scegliere il livello da
// visualizzare in classifica. Stesso stile cyan/viola degli
// altri bottoni dell'app, ma pensato per stare 3 in fila.
// ============================================================
class _FiltroLivelloButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FiltroLivelloButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.buttonFill,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selected ? Colors.cyanAccent : AppColors.buttonBorder,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: selected
                ? Colors.cyanAccent.withOpacity(0.6)
                : AppColors.buttonGlow.withOpacity(0.3),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: selected ? Colors.cyanAccent : AppColors.buttonText,
                    letterSpacing: 0.5,
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

// ============================================================
// _RigaClassifica
// ------------------------------------------------------------
// Widget "privato" (usato solo in questo file) che rappresenta
// UNA singola riga della classifica: posizione + nome + punteggio.
// ============================================================
class _RigaClassifica extends StatelessWidget {
  final int posizione;
  final String nome;
  final int punteggio;

  const _RigaClassifica({
    required this.posizione,
    required this.nome,
    required this.punteggio,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.buttonFill,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.buttonBorder,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.buttonGlow.withOpacity(0.4),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.buttonBorder,
            ),
            child: Center(
              child: Text(
                '$posizione',
                style: const TextStyle(
                  color: AppColors.titleText,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              nome,
              style: const TextStyle(
                color: AppColors.buttonText,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            '$punteggio pt',
            style: const TextStyle(
              color: AppColors.buttonBorder,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}