import 'package:flutter/material.dart';
import 'AppColors.dart';
import 'PageHeader.dart';

class Giocatore {
  final String nome;
  final int punteggio;

  const Giocatore({
    required this.nome,
    required this.punteggio,
  });
}

class ClassificaPage extends StatelessWidget {
  const ClassificaPage({super.key});

  static const List<Giocatore> _datiFinti = [
    Giocatore(nome: 'Walter', punteggio: 87),
    Giocatore(nome: 'Emiliano', punteggio: 120),
    Giocatore(nome: 'Angelo', punteggio: 45),
    Giocatore(nome: 'Francesco', punteggio: 99),
    Giocatore(nome: 'Marco P.', punteggio: 150),
  ];

  @override
  Widget build(BuildContext context) {
    final List<Giocatore> classificaOrdinata = List.from(_datiFinti)
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
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: PageHeader(
                  title: 'CLASSIFICA',
                  fontSize: 28,
                  letterSpacing: 2,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: classificaOrdinata.length,
                  itemBuilder: (context, index) {
                    final Giocatore giocatore = classificaOrdinata[index];
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