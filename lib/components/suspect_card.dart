import 'package:cidade_segura/models/suspect_model.dart';
import 'package:cidade_segura/pages/anotation_form.dart';
import 'package:cidade_segura/util/app_routs.dart';
import 'package:flutter/material.dart';

class SuspectCard extends StatelessWidget {
  const SuspectCard({Key? key, required this.suspect}) : super(key: key);
  final Suspect suspect;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Column(
          children: [Text(suspect.name), SizedBox(), Text(suspect.userEmail)],
        ),
      ),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AnotationForm(suspect: suspect))),
    );
  }
}
