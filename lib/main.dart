import 'package:cidade_segura/pages/anotation_form.dart';
import 'package:cidade_segura/pages/home_page.dart';
import 'package:cidade_segura/pages/suspect_form_form.dart';
import 'package:cidade_segura/service/anotation/anotation_service.dart';
import 'package:cidade_segura/service/suspect/suspect_service.dart';
import 'package:cidade_segura/util/app_routs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const CidadeSegura());
}

class CidadeSegura extends StatelessWidget {
  const CidadeSegura({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SuspectService()),
        ChangeNotifierProvider(create: (context) => AnotationService()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          AppRoutes.HOME: (context) => HomePage(),
          AppRoutes.SUSPECT_FORM: (context) => SuspectForm(),
        },
      ),
    );
  }
}
