import 'package:cidade_segura/models/suspect_model.dart';
import 'package:flutter/material.dart';

class SuspectCard extends StatelessWidget {
  const SuspectCard({Key? key, required this.suspect}) : super(key: key);
  final Suspect suspect;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [Text(suspect.name), SizedBox(), Text(suspect.userEmail)],
      ),
    );
  }
}
