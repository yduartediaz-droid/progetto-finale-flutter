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
  bool isLogin = true; // 🔥 Toggle login/registrazione

  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  bool loading = false;
  String? error;

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
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                ],

                const SizedBox(height: 40),

                ElevatedButton(
                  onPressed: loading
                      ? null
                      : () async {
                    setState(() {
                      loading = true;
                      error = null;
                    });

                    try {
                      final res = isLogin
                          ? await AuthService.login(
                        usernameCtrl.text.trim(),
                        passwordCtrl.text.trim(),
                      )
                          : await AuthService.register(
                        usernameCtrl.text.trim(),
                        passwordCtrl.text.trim(),
                      );

                      await UserStorage.saveUser(
                        res.idUtente,
                        res.username,
                      );

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
                      );
                    } catch (e) {
                      setState(() {
                        error = e.toString();
                      });
                    }

                    setState(() {
                      loading = false;
                    });
                  },
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
