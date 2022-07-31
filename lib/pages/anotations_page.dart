import 'package:cidade_segura/components/anotation_widget.dart';
import 'package:cidade_segura/components/suspect_card.dart';
import 'package:cidade_segura/models/anotation_model.dart';
import 'package:cidade_segura/service/anotation/anotation_service.dart';
import 'package:cidade_segura/service/suspect/suspect_service.dart';
import 'package:cidade_segura/util/app_routs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AnotationsPage extends StatefulWidget {
  AnotationsPage({Key? key, this.suspectId}) : super(key: key);
  String? suspectId;

  @override
  State<AnotationsPage> createState() => _AnotationsPageState();
}

class _AnotationsPageState extends State<AnotationsPage> {
  AnotationService anotationService = AnotationService();

  Future<void> _loadedAnotations(BuildContext context) {
    return Provider.of<AnotationService>(context, listen: false)
        .getAnotations();
  }

  @override
  void initState() {
    super.initState();
    _loadedAnotations(context);
  }

  @override
  Widget build(BuildContext context) {
    final AnotationService anotationService = Provider.of(context);
   final anotacoesDoSuspeito = anotationService.items
        .where((element) => element.suspectId == widget.suspectId)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Anotações'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: anotacoesDoSuspeito.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnotationWidget(
               dateTime: anotacoesDoSuspeito[index].dateTime,
                suspectId: anotacoesDoSuspeito[index].suspectId,
                appUserEmail: anotacoesDoSuspeito[index].userEmail),

          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(AppRoutes.SUSPECT_FORM);
        },
        child: Icon(Icons.person_add),
      ),
    );
  }
}
