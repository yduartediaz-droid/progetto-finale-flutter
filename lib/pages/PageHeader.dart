import 'package:flutter/material.dart';
import 'AppColors.dart';

/// Header riutilizzabile: titolo centrato (stesso stile di prima)
/// + freccia indietro a sinistra che riporta sempre alla Home.
class PageHeader extends StatelessWidget {
  final String title;
  final double fontSize;
  final double letterSpacing;

  const PageHeader({
    super.key,
    required this.title,
    this.fontSize = 64,
    this.letterSpacing = 1.5,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // TITOLO (identico a prima, solo spostato dentro lo Stack)
          Padding(
            // spazio laterale per non far sovrapporre il testo alla freccia
            padding: const EdgeInsets.symmetric(horizontal: 64),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: AppColors.titleText,
                letterSpacing: letterSpacing,
              ),
            ),
          ),

          // FRECCIA INDIETRO -> sempre alla Home
          Positioned(
            left: 0,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
            ),
          ),
        ],
      ),
    );
  }
}