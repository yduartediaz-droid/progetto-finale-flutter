import 'package:flutter/material.dart';
import 'AppColors.dart';
import 'PageHeader.dart';
import '../services/ClassificaService.dart';
import '../models/punteggioResponse.dart';

class ClassificaPage extends StatefulWidget {
  const ClassificaPage({super.key});

  @override
  State<ClassificaPage> createState() => _ClassificaPageState();
}

class _ClassificaPageState extends State<ClassificaPage> {
  String livelloSelezionato = "FACILE";

  late Future<List<PunteggioResponse>> futureClassifica;

  @override
  void initState() {
    super.initState();
    futureClassifica = ClassificaService.getClassifica(livelloSelezionato);
  }

  void _cambiaLivello(String nuovoLivello) {
    setState(() {
      livelloSelezionato = nuovoLivello;
      futureClassifica = ClassificaService.getClassifica(nuovoLivello);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: _FiltroLivelloButton(
                        label: "FACILE",
                        selected: livelloSelezionato == "FACILE",
                        onTap: () => _cambiaLivello("FACILE"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _FiltroLivelloButton(
                        label: "MEDIO",
                        selected: livelloSelezionato == "MEDIO",
                        onTap: () => _cambiaLivello("MEDIO"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _FiltroLivelloButton(
                        label: "DIFFICILE",
                        selected: livelloSelezionato == "DIFFICILE",
                        onTap: () => _cambiaLivello("DIFFICILE"),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: FutureBuilder<List<PunteggioResponse>>(
                  future: futureClassifica,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.cyanAccent),
                      );
                    }

                    final classifica = snapshot.data!;

                    if (classifica.isEmpty) {
                      return const Center(
                        child: Text(
                          "Nessun punteggio ancora registrato\nper questo livello.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      itemCount: classifica.length,
                      itemBuilder: (context, index) {
                        final p = classifica[index];
                        final posizione = index + 1;

                        return _RigaClassifica(
                          posizione: posizione,
                          nome: p.username,
                          punteggio: p.punteggioFinale,
                        );
                      },
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
