// ============================================================
// HOME.DART
// ------------------------------------------------------------
// Questa è la schermata principale (Home) dell'app.
// Struttura generale della pagina (dall'alto verso il basso):
//   1) Sfondo con gradiente viola/magenta (preso da AppColors)
//   2) Logo + Titolo in alto
//   3) 4 pulsanti del menu, uno sotto l'altro
//
// NOTA PER PRINCIPIANTI:
// In Flutter costruisci l'interfaccia "annidando" widget dentro
// altri widget, come scatole cinesi. Ogni blocco commentato qui
// sotto corrisponde a un pezzo visivo preciso dello schermo.
// ============================================================
import 'Regole.dart';
import 'Livello.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'Classifica.dart';
import 'Gioco.dart';
import 'package:flutter/material.dart';
import 'AppColors.dart'; // <-- importiamo i colori dal file separato

// ------------------------------------------------------------
// StatelessWidget = un widget che NON cambia aspetto da solo nel
// tempo (non ha bisogno di "ricordarsi" di uno stato interno).
// La Home è statica: si limita a mostrare logo, titolo e bottoni.
// Se in futuro vorrai animazioni o dati che cambiano qui dentro,
// andrà trasformata in StatefulWidget (te lo spiego se serve).
// ------------------------------------------------------------
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold = la "pagina base" di Flutter, fornisce già la
    // struttura standard (corpo, eventuale barra in alto, ecc.)
    return Scaffold(
      // Il body è tutto il contenuto della schermata
      body: Container(
        // ----------------------------------------------------
        // 1) SFONDO
        // ----------------------------------------------------
        // width/height infinity = riempi tutto lo schermo disponibile
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          // Il gradiente lo prendiamo già pronto da AppColors,
          // così se vuoi cambiare i colori dello sfondo, vai a
          // modificare SOLO app_colors.dart, non questo file.
          gradient: AppColors.backgroundGradient,
        ),

        // SafeArea = evita che i contenuti finiscano sotto la
        // "tacca" del telefono, la barra di stato, ecc.
        child: SafeArea(
          child: Padding(
            // Un po' di spazio (margine) su tutti i lati
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),

            child: Column(
              // mainAxisAlignment.spaceBetween = spinge il primo
              // blocco (logo+titolo) in alto e l'ultimo (bottoni)
              // verso il basso/centro, distribuendo lo spazio
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                // --------------------------------------------
                // 2) LOGO + TITOLO (in alto)
                // --------------------------------------------
                Column(
                  children: [
                    // ---- CARICAMENTO IMMAGINE (logo) ----
                    // Image.asset carica un'immagine salvata nel
                    // progetto (cartella "assets/", da configurare
                    // nel file pubspec.yaml - te lo spiego sotto).
                    //
                    // Per ora uso un "placeholder": un cerchio con
                    // un'icona, così il layout è già pronto e
                    // funzionante. Quando avrai il file del logo,
                    // sostituisci questo blocco con:
                    //
                    //   Image.asset(
                    //     'assets/images/logo.png',
                    //     width: 100,
                    //     height: 100,
                    //   ),
                    //
                    SvgPicture.asset(
                      'assets/images/LogoApp.svg', // <-- cambia con il nome esatto del tuo file
                      width: 100,
                      height: 100,
                    ),

                    const SizedBox(height: 16), // spazio vuoto tra logo e titolo

                    // ---- TESTO TITOLO ----
                    const Text(
                      'Brain Snack', // <-- sostituisci con il nome della tua app
                      style: TextStyle(
                        color: AppColors.titleText,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2, // spazio tra le lettere, effetto "titolo"
                      ),
                    ),
                  ],
                ),

                // --------------------------------------------
                // 3) MENU CON 4 PULSANTI
                // --------------------------------------------
                Column(
                  // mainAxisSize.min = la colonna occupa solo lo
                  // spazio necessario ai suoi figli, non tutto lo
                  // schermo (altrimenti spaceEvenly sopra non
                  // funzionerebbe bene)
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _MenuButton(
                      label: 'GIOCA',
                      onPressed: () {
                        // Qui in futuro metterai la navigazione
                        // verso la pagina del quiz, es:
                        // Navigator.push(context, MaterialPageRoute(
                        //   builder: (context) => const GiocoPage(),
                        // ));
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LivelloPage()),
                        );
                        debugPrint('Hai premuto GIOCA');
                      },
                    ),
                    const SizedBox(height: 20), // spazio tra un bottone e l'altro

                    _MenuButton(
                      label: 'CLASSIFICA',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ClassificaPage()),
                        );
                        debugPrint('Hai premuto CLASSIFICA');
                      },
                    ),
                    const SizedBox(height: 20),
                    //
                    // _MenuButton(
                    //   label: 'LIVELLO',
                    //   onPressed: () {
                    //     debugPrint('Hai premuto LIVELLO');
                    //   },
                    // ),
                    // const SizedBox(height: 20),

                    _MenuButton(
                      label: 'REGOLE',
                      onPressed: () {
                        debugPrint('Hai premuto REGOLE');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegolePage()),
                        );
                      },
                    ),
                  ],
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
// _MenuButton
// ------------------------------------------------------------
// Widget "privato" (il trattino basso _ davanti al nome significa
// che è usato solo dentro questo file) che rappresenta UN SINGOLO
// pulsante del menu, con lo stile "pillola neon" dell'immagine di
// riferimento.
//
// Perché farne un widget separato invece di scrivere 4 volte lo
// stesso codice? Perché così, se domani vuoi cambiare lo STILE
// di tutti i bottoni (es. arrotondarli di più), lo fai in UN
// SOLO posto invece che in 4 punti diversi. Regola generale in
// programmazione: evita di copiare/incollare codice identico.
// ============================================================
class _MenuButton extends StatelessWidget {
  final String label; // il testo scritto dentro al bottone
  final VoidCallback onPressed; // la funzione da eseguire al click

  const _MenuButton({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // il bottone occupa tutta la larghezza disponibile
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.buttonFill,
        // borderRadius alto = forma "a pillola" (angoli molto arrotondati)
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppColors.buttonBorder,
          width: 2,
        ),
        // BoxShadow = il bagliore colorato attorno al bottone
        // (l'effetto "neon" che si vede nell'immagine di riferimento)
        boxShadow: [
          BoxShadow(
            color: AppColors.buttonGlow.withOpacity(0.6),
            blurRadius: 16, // quanto è "sfumato" il bagliore
            spreadRadius: 1, // quanto si espande il bagliore
          ),
        ],
      ),
      // ClipRRect + Material + InkWell = il modo standard in Flutter
      // per avere un effetto "ripple" (cerchio che si espande) al
      // tocco, mantenendo gli angoli arrotondati del Container sopra
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Material(
          color: Colors.transparent, // trasparente: si vede il colore del Container sopra
          child: InkWell(
            onTap: onPressed, // funzione chiamata al click, passata da fuori
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