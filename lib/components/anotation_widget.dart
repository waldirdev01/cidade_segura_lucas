import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnotationWidget extends StatelessWidget {
  const AnotationWidget(
      {Key? key,
        required this.dateTime,
        required this.suspectName,
        required this.appUserEmail})
      : super(key: key);
  final String appUserEmail;
  final String suspectName;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(appUserEmail),
          Text(suspectName),
          Text(DateFormat('dd/MM/yyyy - hh:MM:ss').format(dateTime)),
        ],
      ),
    );
  }
}