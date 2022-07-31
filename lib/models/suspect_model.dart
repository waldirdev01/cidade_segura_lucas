import 'package:cidade_segura/models/anotation_model.dart';

class Suspect {
  String name, id, userEmail;
  List<Anotation>? anotacoes;


  Suspect({required this.id, required this.userEmail, required this.name, });

//Map para enviar dados para o Firebase
  Map<String, Object> toFirebase() {
    return {
      'name': name,
      'userEmail': userEmail,
    };
  }
}