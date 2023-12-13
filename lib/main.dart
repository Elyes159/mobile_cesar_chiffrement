import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_sec_inf/cipherUtils.dart';
import 'package:test_sec_inf/cipherUtils.dart';
import 'package:test_sec_inf/firebase_options.dart';
import 'package:test_sec_inf/home.dart';
import 'package:test_sec_inf/login.dart';
import 'package:test_sec_inf/page1.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        title: 'Cesar Cipher App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CaesarCipherScreen(),
        routes: {
          "login": (context) => Login(),
          "home": (context) => Home(),
        });
  }
}
