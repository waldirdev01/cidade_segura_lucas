class Anotation  {
  String id, anotation, userEmail, suspectId;
  DateTime dateTime;

  Anotation(
      {required this.id,
        required this.dateTime,
        required this.userEmail,
        required this.anotation,
        required this.suspectId});

//Map para enviar dados para o Firebase
  Map<String, Object> toFirebase() {
    return {
      'anotation': anotation,
      'userEmail': userEmail,
      'suspectId': suspectId,
      'dateTime': dateTime.toIso8601String()
    };
  }
//Construtor nomeado para receber os dados do Firebase
  Anotation.fromFirebase(Map<String, Object> map,
      {required this.id,
        required this.userEmail,
        required this.dateTime,
        required this.suspectId,
        required this.anotation}) {
    id = map['id'] as String;
    userEmail = map['userEmail'] as String;
    dateTime = DateTime.parse(map['dateTime'] as String);
    suspectId = map['suspectId'] as String;
    anotation = map['anotation'] as String;
  }
}