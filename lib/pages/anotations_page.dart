import 'package:cidade_segura/components/suspect_card.dart';
import 'package:cidade_segura/service/anotation/anotation_service.dart';
import 'package:cidade_segura/service/suspect/suspect_service.dart';
import 'package:cidade_segura/util/app_routs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnotationsPage extends StatefulWidget {
   AnotationsPage({Key? key, required this.suspectId}) : super(key: key);
  String suspectId;

  @override
  State<AnotationsPage> createState() => _AnotationsPageState();
}

class _AnotationsPageState extends State<AnotationsPage> {
  Future<void> _refreshSuspects(BuildContext context) {
    return Provider.of<AnotationService>(context, listen: false)
        .getAnotations();
  }

  @override
  Widget build(BuildContext context) {
    final AnotationService anotationService = Provider.of(context);
    _refreshSuspects(context);
    final suspectId = ModalRoute
        .of(context)!
        .settings
        .arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: anotationService.itemsCount,
          itemBuilder: (context, index) {
            int filter = anotationService.items
                .indexWhere((element) => element.suspectId == suspectId);
            print('Todos aqui ${filter}');
            if (filter >= 0) {
              final anotacoesDesseSuspeito =
                  anotationService.items.where((prod) =>
                  prod.suspectId == suspectId).toList();
              return Text(anotacoesDesseSuspeito[index].anotation);
            } else {
              return Text('Erro desconhecido, tente mais tarde');
            }
          },
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
