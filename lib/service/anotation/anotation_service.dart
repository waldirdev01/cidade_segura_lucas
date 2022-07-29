import 'package:cidade_segura/models/anotation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnotationService {
  // cria uma instância do FirebaseFirestore
  final db = FirebaseFirestore.instance;

  addAnotation(Anotation anotation) {
    db.collection('anotações').add(anotation.toFirebase());
  }

  Future<List<Anotation>> getAnotations() async {
    var getRef = await db.collection('anotações').get();
    var anotations = getRef.docs
        .map((map) => Anotation(
        id: map.reference.id,
        dateTime: DateTime.now(),
        userEmail: map['userEmail'],
        anotation: map['anotation'],
        suspectId: map['suspectId']))
        .toList();
    return anotations;
  }
}