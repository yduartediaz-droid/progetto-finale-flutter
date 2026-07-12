import 'package:flutter/material.dart';
import 'pages/Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brain Snack',

      // Tema base dell’app (puoi personalizzarlo se vuoi)
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      // Prima schermata mostrata all’avvio
      home: const HomePage(),
    );
  }
}
