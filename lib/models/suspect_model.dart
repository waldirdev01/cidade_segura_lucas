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

}