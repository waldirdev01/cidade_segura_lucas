import 'package:cidade_segura/models/anotation_model.dart';
import 'package:cidade_segura/models/suspect_model.dart';
import 'package:cidade_segura/service/anotation/anotation_service.dart';
import 'package:cidade_segura/util/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SuspectService with ChangeNotifier {

  List<Suspect> _items = [];

  List<Suspect> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  // cria uma instância do FirebaseFirestore
  final db = FirebaseFirestore.instance;

  addSuspect(Suspect suspect) {
    //adiciona uma coleção no Firebase e adiciona um suspeito
    db.collection(Constants.SUSPECT_COLLECTION).add(suspect.toFirebase());
  }

  Future<List<Suspect>> getSuspects() async {
    QuerySnapshot<Map<String, dynamic>> getRef = await db
        .collection(Constants.SUSPECT_COLLECTION)
        .orderBy('name', descending: false)
        .get();
    //recebe os suspeitos
    var suspect = getRef.docs
        .map((map) => Suspect(
            id: map.reference.id, userEmail: 'userEmail', name: map['name']))
        .toList();
    _items = suspect;
    notifyListeners();
    return _items;
    //pega o que vem do DB e converte em uma lista de suspeitos para o app
  }

}
