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
    dateTime = DateTime.now();
    return {
      'anotation': anotation,
      'userEmail': userEmail,
      'suspectId': suspectId,
      'dateTime': dateTime.toIso8601String()
    };
  }

}