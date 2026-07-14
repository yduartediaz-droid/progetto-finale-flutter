import 'package:flutter/material.dart';
import 'pages/Home.dart';
import 'pages/AuthPage.dart';
import 'storage/UserStorage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final loggedIn = await UserStorage.isLoggedIn();

  runApp(MyApp(initialLoggedIn: loggedIn));
}

class MyApp extends StatelessWidget {
  final bool initialLoggedIn;

  const MyApp({super.key, required this.initialLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brain Snack',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      home: initialLoggedIn ? const HomePage() : const AuthPage(),
    );
  }
}
