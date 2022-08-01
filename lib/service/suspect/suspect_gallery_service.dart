/*

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SuspectGalleryService extends StatefulWidget {
  const SuspectGalleryService({Key? key}) : super(key: key);

  @override
  State<SuspectGalleryService> createState() => _SuspectGalleryServiceState();
}

class _SuspectGalleryServiceState extends State<SuspectGalleryService> {
  late XFile? imagePick;
  pickAndUploadImage() async {
    XFile? file = await imagePick;
    if (file != null) {
      UploadTask task = await storageService.upload(file.path);
      task.snapshotEvents.listen((TaskSnapshot snapshot) async {
        if (snapshot.state == TaskState.running) {
          setState(() {
            uploading = true;
            total = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
          });
        } else if (snapshot.state == TaskState.success) {
          arquivos.add(await snapshot.ref.getDownloadURL());
          imagemBaixada = arquivos.last;
          refs.add(snapshot.ref);
          setState(() => uploading = false);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => FormCadastroPessoaPage(urlImage: imagemBaixada)));
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
*/
