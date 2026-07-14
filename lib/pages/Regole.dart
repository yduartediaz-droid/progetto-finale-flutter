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
                    _SezioneTitolo('Istruzioni del Gioco '),

                    _Paragrafo(
                      titolo: 'Come si inizia',
                      corpo:
                         '1. Ocorre registrarsi con Utente e Pasword\n'
                             '2.Dalla Home premi GIOCA per accedere alla selezione della partita\n'
                             '3 . Scegli il livello di difficoltà (FACILE / MEDIO / DIFFICILE)\n'
                          '4. Premi START per iniziare',
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
                      'Risposta corretta:  10 punti\n'
                          'Il punteggio è identico indipendentemente dal livello scelto: '

                    ),

                    _Paragrafo(
                      titolo: 'Svolgimento della partita',
                      corpo:
                      '1. Le domande arrivano a blocchi da 10,15,25  in '
                          'base al livello scelto\n'
                          '2. Il punteggio totale accumulato viene registrato in classifica',
                    ),

                    SizedBox(height: 12),
                    Divider(color: AppColors.buttonBorder, thickness: 1),
                    SizedBox(height: 12),

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