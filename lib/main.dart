import 'package:flutter/material.dart';
import 'package:water/about_page.dart';
import 'package:water/display_page.dart';
import 'package:water/welcome_page.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 168, 240, 86)),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(color: Colors.amber,),
      ),

      routes: {
        '/': (context) => const WelcomePage(),
        '/about': (context) => const AboutPage(),
        '/display': (context) => const DisplayPage(name: ''),
      },
      initialRoute: '/',
      //home: WelcomePage()
    );
  }
}