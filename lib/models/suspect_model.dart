import 'package:cidade_segura/models/anotation_model.dart';

class Suspect {
  final String name, id, userEmail;
  final List<dynamic> urlImage;

  Suspect(
      {required this.id,
      required this.userEmail,
      required this.name,
      required this.urlImage});

//Map para enviar dados para o Firebase
  Map<String, Object> toFirebase() {
    return {
      'name': name,
      'userEmail': userEmail,
      'urlImage': urlImage.toList(),
    };
  }
}
