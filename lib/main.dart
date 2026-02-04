import 'package:flutter/material.dart';
import 'package:water/about_page.dart';
import 'package:water/topup_page.dart';
import 'package:water/home_page.dart';
import 'package:water/topup_report.dart';
import 'package:water/balance_page.dart';
import 'package:water/mylist_page.dart';
import 'package:water/my_futurebuilder_page.dart';
import 'package:water/http_basic.dart';

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
        appBarTheme: const AppBarTheme(backgroundColor: Colors.amber),
      ),
      initialRoute: '/',
      routes: {
        // '/': (context) => const HomePage(),
        '/': (context) => const HttpBasic(),
        '/about': (context) => const AboutPage(),
        '/topup': (context) => const TopupPage(),
        '/topupReport': (context) => const TopupReport(),
        '/balancePage': (context) => const BalancePage(),
        '/mylistPage': (context) => const MylistPage(),
        //'/myfuturebuilderPage': (context) => const MyFutureBuilderPage(),
        //'httpBasic': (context) => HttpBasic(),
      },
    );
  }
}