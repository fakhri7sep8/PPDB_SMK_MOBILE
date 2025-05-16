import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ppdb_mobile/firebase_options.dart';
import 'package:ppdb_mobile/presentation/pages/home.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Layoting Dasar',
      home:HomePage(),
    );
  }
}
