import 'package:cidade_segura/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CidadeSegura());
}

class CidadeSegura extends StatelessWidget {
  const CidadeSegura({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

