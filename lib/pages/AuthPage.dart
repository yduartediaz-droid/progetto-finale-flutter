import 'package:flutter/material.dart';
import '../services/AuthService.dart';
import '../storage/UserStorage.dart';
import 'Home.dart';
import 'AppColors.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  bool loading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    _checkAutoLogin(); // 🔥 controllo login persistente
  }

  Future<void> _checkAutoLogin() async {
    final loggedIn = await UserStorage.isLoggedIn();
    if (loggedIn) {
      // 🔥 Utente già loggato → salto AuthPage
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    }
  }

  Future<void> _submit() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final username = usernameCtrl.text.trim();
      final password = passwordCtrl.text.trim();

      if (username.isEmpty || password.isEmpty) {
        throw "Inserisci username e password";
      }

      final res = isLogin
          ? await AuthService.login(username, password)
          : await AuthService.register(username, password);

      await UserStorage.saveUser(res.idUtente, res.username);

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } catch (e) {
      setState(() {
        String erroreStr = e.toString();
        String messaggioPulito;

        // Gestione degli errori di rete (es. Server offline o IP irraggiungibile)
        if (erroreStr.contains("SocketException") || 
            erroreStr.contains("ClientException") || 
            erroreStr.contains("Connection refused")) {
          messaggioPulito = "Impossibile connettersi al server. Verifica la tua connessione.";
        } else {
          // Rimuove il prefisso "Exception: " se generato dal framework, altrimenti prende l'errore pulito
          messaggioPulito = erroreStr.replaceFirst("Exception: ", "");
        }

        // 🔥 Aggiunta del prefisso "Attenzione!!! " richiesto
        error = "Attenzione!!! $messaggioPulito";
      });
    }

    setState(() {
      loading = false;
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
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  isLogin ? "LOGIN" : "REGISTRAZIONE",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 40),

                TextField(
                  controller: usernameCtrl,
                  decoration: const InputDecoration(
                    labelText: "Username",
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: passwordCtrl,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),

                if (error != null) ...[
                  const SizedBox(height: 20),
                  Text(
                    error!,
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],

                const SizedBox(height: 40),

                ElevatedButton(
                  onPressed: loading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonBorder,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          isLogin ? "ACCEDI" : "REGISTRATI",
                          style: const TextStyle(fontSize: 20),
                        ),
                ),

                const SizedBox(height: 20),

                TextButton(
                  onPressed: () {
                    setState(() {
                      isLogin = !isLogin;
                      error = null;
                    });
                  },
                  child: Text(
                    isLogin
                        ? "Non hai un account? Registrati"
                        : "Hai già un account? Accedi",
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}