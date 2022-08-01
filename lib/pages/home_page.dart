import 'package:cidade_segura/components/custom_page.dart';
import 'package:cidade_segura/components/suspect_card.dart';
import 'package:cidade_segura/service/suspect/suspect_service.dart';
import 'package:cidade_segura/util/app_routs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _loadedSuspects(BuildContext context) {
    return Provider.of<SuspectService>(context, listen: false).getSuspects();
  }

  @override
  void initState() {
    super.initState();
    _loadedSuspects(context);
  }

  @override
  Widget build(BuildContext context) {
    final SuspectService suspects = Provider.of(context);
    return CustomPage(
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
          Navigator.of(context).pushReplacementNamed(AppRoutes.GETIMAGEFACE);
        },
        child: Icon(Icons.person_add),
      ),
    );
  }
}
