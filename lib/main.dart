import 'package:chattingapp/firebase_options.dart';
import 'package:chattingapp/services/auth/auth_gate.dart';
import 'package:chattingapp/themes/light_mode.dart';
import 'package:chattingapp/themes/theme_mode_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeModeProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeModeProvider>(context).themeData,
      home: const AuthGate(),
    );
  }
}
