import 'package:flutter/material.dart';
import 'package:app_movil/Pages/HomePage.dart';
import 'package:app_movil/Pages/NextPage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/home', // Ruta inicial
      routes: {
        '/home': (context) => const HomePage(), // Ruta para la página de inicio
        '/next': (context) => const NextPage(), // Ruta para la página siguiente
      },
    );
  }
}
