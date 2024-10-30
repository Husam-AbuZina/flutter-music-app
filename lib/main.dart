import 'package:flutter/material.dart';
import './views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
      title: 'Beats',
      theme: ThemeData(
        fontFamily: "regular",
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
      ),
    );
  }
}
