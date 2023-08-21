import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travel_guide/firebase_options.dart';
import 'package:travel_guide/injection.dart';
import 'package:travel_guide/sett_al_kol_material.dart';

void main() async {
  init();
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SettAlKolMaterialApp());
}
