// ============================================================
// CLASSIFICA.DART
// ------------------------------------------------------------
// Schermata che mostra la classifica dei giocatori, ordinata
// dal punteggio PIÙ ALTO (posizione 1) al più basso (posizione n).
//
// Per ora i dati sono FINTI (scritti a mano nel codice, riga
// "DATI DI ESEMPIO" più sotto). Quando collegherai il backend
// Spring Boot, basterà sostituire quella lista con i dati veri
// presi da una chiamata HTTP: la struttura della pagina resta
// identica, cambia solo DA DOVE arrivano i dati.
// ============================================================

import 'package:flutter/material.dart';
import 'AppColors.dart'; // stessi colori usati nella Home, per coerenza grafica

// ------------------------------------------------------------
// MODELLO DATI
// ------------------------------------------------------------
// Una piccola classe che rappresenta UN giocatore in classifica.
// Non è un'Entity JPA come nel backend: qui è solo un "contenitore"
// di dati usato lato Flutter per disegnare la lista a schermo.
// ------------------------------------------------------------
class Giocatore {
  final String nome;
  final int punteggio;

  const Giocatore({
    required this.nome,
    required this.punteggio,
  });
}

// ------------------------------------------------------------
// StatelessWidget: per ora la pagina non deve "ricordarsi" di
// nessun cambiamento nel tempo (i dati sono fissi), quindi
// StatelessWidget va benissimo. Quando i dati arriveranno dal
// backend (caricamento asincrono), la trasformeremo in
// StatefulWidget: te lo spiego quando arriviamo a quel punto.
// ------------------------------------------------------------
class ClassificaPage extends StatelessWidget {
  const ClassificaPage({super.key});

  // ----------------------------------------------------------
  // DATI DI ESEMPIO (finti)
  // ----------------------------------------------------------
  // Lista scritta a mano, NON ancora ordinata di proposito:
  // vogliamo dimostrare che l'ordinamento lo fa il codice sotto,
  // non l'ordine in cui scrivi gli elementi qui.
  // ----------------------------------------------------------
  static const List<Giocatore> _datiFinti = [
    Giocatore(nome: 'Walter', punteggio: 87),
    Giocatore(nome: 'Emiliano', punteggio: 120),
    Giocatore(nome: 'Angelo', punteggio: 45),
    Giocatore(nome: 'Francesco', punteggio: 99),
    Giocatore(nome: 'Marco P.', punteggio: 150),
  ];

  @override
  Widget build(BuildContext context) {
    // ----------------------------------------------------------
    // ORDINAMENTO: dal punteggio più alto al più basso
    // ----------------------------------------------------------
    // List.from(...) crea una COPIA della lista originale: non
    // modifichiamo mai direttamente _datiFinti (buona pratica,
    // evita effetti collaterali imprevisti se il metodo build()
    // viene chiamato più volte).
    //
    // sort() ordina la lista IN BASE al confronto che gli dai tu
    // tra due elementi (a, b). Restituire:
    //   - un numero negativo -> "a" viene prima di "b"
    //   - un numero positivo -> "a" viene dopo "b"
    //
    // (b.punteggio - a.punteggio) ordina DAL PIÙ ALTO AL PIÙ BASSO.
    // Se scrivessimo (a.punteggio - b.punteggio) sarebbe l'opposto
    // (dal più basso al più alto).
    final List<Giocatore> classificaOrdinata = List.from(_datiFinti)
      ..sort((a, b) => b.punteggio - a.punteggio);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // Stesso sfondo a gradiente usato nella Home, preso da AppColors
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ------------------------------------------------
              // TITOLO DELLA PAGINA
              // ------------------------------------------------
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  'CLASSIFICA',
                  style: TextStyle(
                    color: AppColors.titleText,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),

              // ------------------------------------------------
              // LISTA DEI GIOCATORI
              // ------------------------------------------------
              // Expanded dice al widget dentro (la ListView) di
              // occupare TUTTO lo spazio verticale rimanente sotto
              // il titolo. Senza Expanded, una ListView dentro una
              // Column darebbe errore ("altezza non definita").
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  // Quanti elementi disegnare: uno per ogni giocatore
                  itemCount: classificaOrdinata.length,
                  // Questa funzione viene chiamata automaticamente
                  // da Flutter per OGNI elemento della lista, passando
                  // l'indice (index) di quell'elemento: 0, 1, 2, ...
                  itemBuilder: (context, index) {
                    final Giocatore giocatore = classificaOrdinata[index];
                    // La posizione in classifica è l'indice + 1
                    // (l'indice della lista parte da 0, ma la
                    // posizione mostrata all'utente parte da 1)
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
// _RigaClassifica
// ------------------------------------------------------------
// Widget "privato" (usato solo in questo file) che rappresenta
// UNA singola riga della classifica: posizione + nome + punteggio,
// con lo stesso stile "pillola neon" usato per i bottoni della Home.
// Stesso motivo di prima: evitare di ripetere lo stesso codice
// di stile per ogni riga della lista.
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
      margin: const EdgeInsets.only(bottom: 16), // spazio tra una riga e l'altra
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
      // Row = mette gli elementi in fila ORIZZONTALE (a differenza
      // di Column che li impila verticalmente)
      child: Row(
        children: [
          // ---- Cerchietto con il numero di posizione ----
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.buttonBorder,
            ),
            child: Center(
              child: Text(
                '$posizione', // converte il numero intero in testo
                style: const TextStyle(
                  color: AppColors.titleText,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          const SizedBox(width: 16), // spazio tra cerchio e nome

          // ---- Nome del giocatore ----
          // Expanded qui fa sì che il nome occupi tutto lo spazio
          // orizzontale disponibile, spingendo il punteggio tutto
          // a destra della riga.
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

          // ---- Punteggio ----
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