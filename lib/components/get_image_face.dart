import 'dart:io';
import 'dart:math';
import 'package:cidade_segura/models/suspect_model.dart';
import 'package:cidade_segura/service/suspect/suspect_gallery_service.dart';
import 'package:cidade_segura/service/suspect/suspect_service.dart';
import 'package:cidade_segura/util/app_routs.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GetImageFace extends StatefulWidget {
  const GetImageFace({
    Key? key,
  }) : super(key: key);

  @override
  State<GetImageFace> createState() => _GetImageFaceState();
}

class _GetImageFaceState extends State<GetImageFace> {
  bool hasImage = false;
  XFile? imagePick;
  late String loadedImage;
  double total = 0;
  bool uploading = false;
  final _formKey = GlobalKey<FormState>();
  //chave para o formulário
  late UploadTask task;
  List<Reference> refs = [];
  List<String> arquivos = [];






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              InkWell(
                onTap: () => _exibirDialog(context),
                child: uploading
                    ? SizedBox(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 200,
                          width: 200,
                          child: CircularProgressIndicator(),
                        ),
                        const Divider(),
                        Text(
                          '${total.round()}% enviado',
                          style: const TextStyle(fontSize: 24),
                        )
                      ],
                    ))
                    : SizedBox(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  child: hasImage
                      ? Image.file(File(imagePick!.path))
                      : Image.asset(
                    'assets/images/avatar.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Divider(),
              ElevatedButton(
                onPressed: uploading ? null : () {
                  pickAndUploadImage();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 55),
                  primary: Theme.of(context).colorScheme.secondary,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text(
                  hasImage ? 'Subir imagem' : 'Click na imagem acima',
                  style: const TextStyle(fontSize: 24),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  pickAndUploadImage() async {
    XFile? file = imagePick;
    if (file != null) {
      UploadTask task = await StorageService().upload(file.path);
      task.snapshotEvents.listen((TaskSnapshot snapshot) async {
        if (snapshot.state == TaskState.running) {
          setState(() {
            uploading = true;
            total = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
          });
        } else if (snapshot.state == TaskState.success) {
          arquivos.add(await snapshot.ref.getDownloadURL());
          loadedImage = arquivos.last;

          refs.add(snapshot.ref);
          setState(() => uploading = false);
          Navigator.of(context)
              .pushReplacementNamed(AppRoutes.SUSPECT_FORM, arguments: loadedImage);
        }
      });
    }
  }

  Future<XFile?> getImage(String fonteDaImagem) async {
    XFile? file = await ImagePicker().pickImage(
        source: fonteDaImagem == 'camera'
            ? ImageSource.camera
            : ImageSource.gallery,
        imageQuality: 60);

    imagePick = XFile(file!.path);
    try {
      hasImage = true;
      setState(() {});
      return imagePick;
    } catch (e) {
      showDialog(context: context, builder: (context) => Text(e.toString()));
    }
    return imagePick;
  }

  _exibirDialog(
      BuildContext context,
      ) {
    AlertDialog alertDialog = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40))),
      backgroundColor: Theme.of(context).primaryColor,
      title: const Text(
        'Escolha a fonte da imagem',
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        TextButton(
            onPressed: () {
              getImage('camera');
              Navigator.pop(context);
            },
            child: Column(
              children: const [
                Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
                Text(
                  'câmera',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            )),
        const SizedBox(
          width: 100,
        ),
        TextButton(
            onPressed: () {
              getImage('gallery');
              Navigator.pop(context);
            },
            child: Column(
              children: const [
                Icon(
                  Icons.photo_album,
                  color: Colors.white,
                ),
                Text('galeria',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ],
            )),
      ],
    );
    showDialog(
        context: context, builder: (BuildContext context) => alertDialog);
  }
}
