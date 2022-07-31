import 'package:cidade_segura/models/anotation_model.dart';
import 'package:cidade_segura/models/suspect_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AnotationService with ChangeNotifier {
  List<Anotation> _items = [];

  List<Anotation> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  // cria uma instância do FirebaseFirestore
  final db = FirebaseFirestore.instance;

  addAnotation(Anotation anotation) async {
    //adiciona uma anotação no Firebase
    await db.collection('anotações').add(anotation.toFirebase());
  }

  Future<List<Anotation>> getAnotations() async {
    var getRef = await db
        .collection('anotações')
        .get();
    //recebe as anotações
    var anotations = getRef.docs
        .map((map) => Anotation(
            id: map.reference.id,
            dateTime: DateTime.parse(map['dateTime']),
            userEmail: map['userEmail'],
            anotation: map['anotation'],
            suspectId: map['suspectId']))
        .toList();
    _items = anotations;
    notifyListeners();
    return _items;
    //pega o que vem do DB e converte em uma lista de anotações para o app
  }
}
