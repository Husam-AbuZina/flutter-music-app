import 'package:flutter/material.dart';
import '../consts/text_style.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Beats", style: ourStyle()),
        ),
        body: Container());
  }
}
