import 'package:flutter/material.dart';
import 'package:nerd_quizz_flutter_final/providers/auth_provider.dart';
import 'package:nerd_quizz_flutter_final/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart'; // 1. Importe o Firebase Core
import 'firebase_options.dart'; // 2. Importe o arquivo que foi criado

// 3. Transforme o main em 'async'
Future<void> main() async {
  // 4. Garanta que o Flutter está pronto
  WidgetsFlutterBinding.ensureInitialized();

  // 5. Inicialize o Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 6. Registre seu Provider
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
