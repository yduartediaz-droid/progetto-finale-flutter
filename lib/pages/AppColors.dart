// ============================================================
// APP_COLORS.DART
// ------------------------------------------------------------
// Questo file contiene SOLO i colori usati nell'app.
// Perché un file separato?
// -> Se domani vuoi cambiare la palette (es. da viola a blu),
//    modifichi solo QUI, senza toccare il codice della Home
//    o delle altre pagine. Tieni la "grafica" separata dalla
//    "logica/struttura" dei widget.
// ============================================================

import 'package:flutter/material.dart';

class AppColors {

  static const Color backgroundTop = Color(0xFF1A0B2E);
  // Il colore "in basso" del gradiente di sfondo
  static const Color backgroundBottom = Color(0xFF3B0F5C);

  // ---- BOTTONI (stile "pillola" con bordo neon) ----
  // Colore di riempimento interno del bottone (leggermente trasparente
  // per far intravedere lo sfondo dietro, come nell'immagine di riferimento)
  static const Color buttonFill = Color(0x33FFFFFF); // bianco al 20% di opacità

  // Colore del bordo luminoso del bottone (l'effetto "neon")
  static const Color buttonBorder = Color(0xFF00E5FF); // ciano acceso

  // Colore del "bagliore" (glow/ombra colorata) attorno al bottone
  static const Color buttonGlow = Color(0xFFFF2E9F); // magenta acceso

  // ---- TESTI ----
  // Colore del titolo principale in alto (es. "QUIZ")
  static const Color titleText = Color(0xFFFFFFFF); // bianco puro

  // Colore del testo scritto DENTRO i bottoni del menu
  static const Color buttonText = Color(0xFFFFFFFF); // bianco puro

  // ---- HELPER: il gradiente pronto all'uso ----
  // Invece di riscrivere ogni volta i due colori sopra, uso
  // questo oggetto già pronto direttamente nella Home.
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [backgroundTop, backgroundBottom],
  );
}