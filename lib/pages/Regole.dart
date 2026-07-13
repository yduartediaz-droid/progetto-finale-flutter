import 'package:flutter/material.dart';
import 'AppColors.dart';
import 'PageHeader.dart';

class RegolePage extends StatelessWidget {
  const RegolePage({super.key});

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
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: PageHeader(
                  title: 'REGOLAMENTO',
                  fontSize: 28,
                  letterSpacing: 2,
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  children: const [
                    _SezioneTitolo('VERSIONE A — Punteggio fisso'),

                    _Paragrafo(
                      titolo: 'Come si inizia',
                      corpo:
                      '1. Dalla Home, premi GIOCA per accedere alla selezione della partita\n'
                          '2. Scegli il livello di difficoltà (FACILE / MEDIO / DIFFICILE)\n'
                          '3. Premi START per iniziare',
                    ),

                    _Paragrafo(
                      titolo: 'Materie disponibili',
                      corpo:
                      'Matematica, Storia, Geografia, Generale, Scienze, Informatica, '
                          'Letteratura, Arte, Musica, Sport, Cinema, Tecnologia, Cultura Pop, '
                          'Educazione Civica, Lingue, Curiosità, Salute e Benessere, Cucina, '
                          'Geopolitica, Economia, Psicologia',
                    ),

                    _Paragrafo(
                      titolo: 'Punteggio',
                      corpo:
                      'Risposta corretta: +2 punti\n'
                          'Risposta sbagliata: -0.50 punti\n\n'
                          'Il punteggio è identico indipendentemente dal livello scelto: '
                          'livello e materia determinano solo quali domande vengono proposte, '
                          'non il valore delle risposte.',
                    ),

                    _Paragrafo(
                      titolo: 'Svolgimento della partita',
                      corpo:
                      '1. Le domande arrivano a blocchi da 10, in '
                          'base al livello scelto\n'
                          '2. Per ogni domanda: risposta corretta → +2 punti e curiosità '
                          'mostrata; risposta sbagliata → -0.50 punti, si prosegue\n'
                          '3. Al termine del blocco, il giocatore può continuare (nuovo '
                          'blocco da 10, stesso livello) o fermarsi\n'
                          '4. Il punteggio totale accumulato viene registrato in classifica',
                    ),

                    SizedBox(height: 12),
                    Divider(color: AppColors.buttonBorder, thickness: 1),
                    SizedBox(height: 12),

                    _SezioneTitolo('VERSIONE B — Punteggio scalato per difficoltà'),

                    _Paragrafo(
                      titolo: 'Come si inizia',
                      corpo:
                      '1. Dalla Home, premi GIOCA per accedere alla selezione della partita\n'
                          '2. Scegli il livello di difficoltà (FACILE / MEDIO / DIFFICILE)\n'
                          '3. Premi START per iniziare',
                    ),

                    _Paragrafo(
                      titolo: 'Materie disponibili',
                      corpo:
                      'Matematica, Storia, Geografia, Generale, Scienze, Informatica, '
                          'Letteratura, Arte, Musica, Sport, Cinema, Tecnologia, Cultura Pop, '
                          'Educazione Civica, Lingue, Curiosità, Salute e Benessere, Cucina, '
                          'Geopolitica, Economia, Psicologia',
                    ),

                    _Paragrafo(
                      titolo: 'Punteggio',
                      corpo:
                      'FACILE:     +1 punto corretta   /  -0.25 punti sbagliata\n'
                          'MEDIO:      +2 punti corretta   /  -0.50 punti sbagliata\n'
                          'DIFFICILE:  +3 punti corretta   /  -0.75 punti sbagliata\n\n'
                          'Il rapporto tra punti guadagnati e persi resta costante (4:1) '
                          'su tutti i livelli.',
                    ),

                    _Paragrafo(
                      titolo: 'Svolgimento della partita',
                      corpo:
                      '1. Le domande arrivano a blocchi da 10, verranno caricate in '
                          'base al livello scelto\n'
                          '2. Per ogni domanda: risposta corretta → punti in base al livello '
                          'scelto + curiosità mostrata; risposta sbagliata → penalità in base '
                          'al livello scelto, si prosegue\n'
                          '3. Al termine del blocco, il giocatore può continuare (nuovo '
                          'blocco da 10, stessa materia/livello) o fermarsi\n'
                          '4. Il punteggio totale accumulato viene registrato in classifica',
                    ),

                    SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SezioneTitolo extends StatelessWidget {
  final String testo;

  const _SezioneTitolo(this.testo);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        testo,
        style: const TextStyle(
          color: AppColors.buttonBorder,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _Paragrafo extends StatelessWidget {
  final String titolo;
  final String corpo;

  const _Paragrafo({
    required this.titolo,
    required this.corpo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titolo,
            style: const TextStyle(
              color: AppColors.titleText,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            corpo,
            style: const TextStyle(
              color: AppColors.buttonText,
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}