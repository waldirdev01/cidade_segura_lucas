import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnotationWidget extends StatelessWidget {
  const AnotationWidget(
      {Key? key,
        required this.dateTime,
        required this.suspectId,
        required this.appUserEmail})
      : super(key: key);
  final String appUserEmail;
  final String suspectId;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(appUserEmail),
          Text(suspectId),
          Text(DateFormat('dd/MM/yyyy - hh:MM:ss').format(dateTime)),
        ],
      ),
    );
  }
}