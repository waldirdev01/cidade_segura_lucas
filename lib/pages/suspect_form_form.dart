import 'dart:math';

import 'package:cidade_segura/models/anotation_model.dart';
import 'package:cidade_segura/models/suspect_model.dart';
import 'package:cidade_segura/service/anotation/anotation_service.dart';
import 'package:cidade_segura/service/suspect/suspect_service.dart';
import 'package:cidade_segura/util/app_routs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SuspectForm extends StatefulWidget {
  const SuspectForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SuspectForm> createState() => _SuspectFormState();
}

class _SuspectFormState extends State<SuspectForm> {
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  //chave para o formulário

  final nameController = TextEditingController();

  Future<void> _submitForm() async {
    final suspect = Suspect(
        id: Random().nextDouble().toString(),
        userEmail: 'userEmail',
        name: nameController.text);

    try {
      await Provider.of<SuspectService>(context, listen: false)
          .addSuspect(suspect);

      Navigator.of(context).pushReplacementNamed(AppRoutes.HOME, arguments: suspect);
    } catch (error) {
      print('Aqui');
      print(error);
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
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
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Nome do suspeitos',
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
