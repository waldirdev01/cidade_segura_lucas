class Suspect {
  String name, id, userEmail;

  Suspect({required this.id, required this.userEmail, required this.name});

//Map para enviar dados para o Firebase
  Map<String, Object> toFirebase() {
    return {
      'name': name,
      'userEmail': userEmail,
    };
  }
//Construtor nomeado para receber os dados do Firebase
  Suspect.fromFirebase(Map<String, Object> map,
      {required this.id, required this.userEmail, required this.name}) {
    id = map['id'] as String;
    name = map['name'] as String;
    userEmail = map['userEmail'] as String;
  }
}