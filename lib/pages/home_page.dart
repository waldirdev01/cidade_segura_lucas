import 'package:cidade_segura/components/suspect_card.dart';
import 'package:cidade_segura/service/suspect/suspect_service.dart';
import 'package:cidade_segura/util/app_routs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Future<void> _refreshSuspects(BuildContext context) {
    return Provider.of<SuspectService>(context, listen: false).getSuspects();
  }

  @override
  Widget build(BuildContext context) {
    final SuspectService suspects = Provider.of(context);
    _refreshSuspects(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: suspects.itemsCount,
          itemBuilder: (context, index) =>
              SuspectCard(suspect: suspects.items[index]),
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
