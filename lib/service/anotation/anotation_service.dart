import 'package:cidade_segura/models/anotation_model.dart';
import 'package:cidade_segura/models/suspect_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AnotationService with ChangeNotifier {

  // cria uma instância do FirebaseFirestore
  final db = FirebaseFirestore.instance;

  addAnotation(Anotation anotation) {
    //adiciona uma anotação no Firebase
    db.collection('anotações').add(anotation.toFirebase());
  }

  Future<List<Anotation>> getAnotations() async {
    var getRef = await db.collection('anotações').get();
    //recebe as anotações
    var anotations = getRef.docs
        .map((map) => Anotation(
        id: map.reference.id,
        dateTime: DateTime.now(),
        userEmail: map['userEmail'],
        anotation: map['anotation'],
        suspectId: map['suspectId']))
        .toList();
    notifyListeners();
    return anotations;
    //pega o que vem do DB e converte em uma lista de anotações para o app
  }
}