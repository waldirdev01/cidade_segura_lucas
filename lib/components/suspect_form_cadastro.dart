import 'dart:math';

import 'package:cidade_segura/models/suspect_model.dart';
import 'package:cidade_segura/service/suspect/suspect_service.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../util/app_routs.dart';


class SuspectFormCadastro extends StatefulWidget {
  const SuspectFormCadastro({
    Key? key,
  }) : super(key: key);

  @override
  State<SuspectFormCadastro> createState() => _SuspectFormCadastroState();
}

class _SuspectFormCadastroState extends State<SuspectFormCadastro> {
  bool isImage = false;
  bool hasPerson = false;
  late XFile imagePick;
  ImagePicker picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};
  final nameController = TextEditingController();
  bool _isLoading = false;

  Future<void> _submitForm() async {

    final suspect = Suspect(
        id: Random().nextDouble().toString(),
        userEmail: 'user',
        name: nameController.text,
        urlImage: ['url1', 'url2', 'url3', 'url4', ]
    );

    try {
      await Provider.of<SuspectService>(context, listen: false)
          .addSuspect(suspect);
      Navigator.of(context).pushReplacementNamed(AppRoutes.HOME,);
    } catch (error) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ocorreu um erro! Envie uma imagem da mensagem para o administrador'),
          content: Text(error.toString()),
          actions: [
            TextButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pushReplacementNamed(AppRoutes.HOME),
            ),
          ],
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  update() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final imagemBaixada = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Pessoa'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Image.network(imagemBaixada)),
                ],
              ),
              const Divider(),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: nameController,
                      showCursor: true,
                      cursorColor: Colors.black,
                      textCapitalization: TextCapitalization.words,
                      style: const TextStyle(fontSize: 24),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2, color: Colors.red),
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        labelText: 'Nome',
                        labelStyle:
                            const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (_name) {
                        final name = _name ?? '';
                        if (name.trim().isEmpty) {
                          return 'Nome é obrigatório';
                        }
                        if (name.trim().length < 3) {
                          return 'O nome precisa ter no mínimo 3 letras.';
                        }
                        return null;
                      },
                      onSaved: (name) {
                        nameController.text = name ?? '';
                      },
                    ),
                    const Divider(),

                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(100, 55),
                        primary: Theme.of(context).colorScheme.secondary,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: const Text(
                        'Cadastrar',
                        style: TextStyle(fontSize: 24),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
