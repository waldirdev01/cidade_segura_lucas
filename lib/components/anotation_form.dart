import 'package:cidade_segura/models/anotation_model.dart';
import 'package:cidade_segura/models/suspect_model.dart';
import 'package:cidade_segura/pages/anotations_page.dart';
import 'package:cidade_segura/service/anotation/anotation_service.dart';
import 'package:cidade_segura/service/suspect/suspect_service.dart';
import 'package:cidade_segura/util/app_routs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnotationForm extends StatefulWidget {
  AnotationForm({
    Key? key,
    required this.suspect,
  }) : super(key: key);
  Suspect? suspect;

  @override
  State<AnotationForm> createState() => _AnotationFormState();
}

class _AnotationFormState extends State<AnotationForm> {
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  //chave para o formulário

  final anotationController = TextEditingController();

  Future<void> _submitForm() async {
    final anotation = Anotation(
        id: 'id',
        dateTime: DateTime.now(),
        userEmail: 'userEmail',
        anotation: anotationController.text,
        suspectId: widget.suspect!.id);

    try {
      await Provider.of<AnotationService>(context, listen: false)
          .addAnotation(anotation);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AnotationsPage(
                suspectId: widget.suspect?.id,
              )));
    } catch (error) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ocorreu um erro!'),
          content: Text('Ocorreu um erro para salvar a anotação'),
          actions: [
            TextButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: anotationController,
                decoration: InputDecoration(
                  labelText: 'Anotação',
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    _submitForm();
                  },
                  child: Icon(Icons.add))
            ],
          ),
        ),
      ),
    );
  }
}
