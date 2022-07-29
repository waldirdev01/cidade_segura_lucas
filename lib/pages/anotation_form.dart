import 'package:cidade_segura/models/anotation_model.dart';
import 'package:cidade_segura/service/anotation/anotation_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnotationForm extends StatefulWidget {
  const AnotationForm({Key? key,}) : super(key: key);


  @override
  State<AnotationForm> createState() => _AnotationFormState();
}

class _AnotationFormState extends State<AnotationForm> {
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  //chave para o formulário

  final anotationController = TextEditingController();


  Future<void> _submitForm() async {
   final anotation = Anotation(id: 'id',
        dateTime: DateTime.now(),
        userEmail: 'userEmail',
        anotation: anotationController.text,
        suspectId: 'suspectId');

    try {
      await Provider.of<AnotationService>(context, listen: false).addAnotation(anotation);

      Navigator.of(context).pop();
    } catch (error) {
      print('Aqui');
      print(error);
      await showDialog<void>(
        context: context,
        builder: (ctx) =>
            AlertDialog(
              title: Text('Ocorreu um erro!'),
              content: Text('Ocorreu um erro para salvar o produto.'),
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
              ElevatedButton(onPressed: _submitForm, child: Icon(Icons.add))
            ],
          ),
        ),
      ),
    );
  }
}
