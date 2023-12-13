import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_sec_inf/cipherUtils.dart';

class CaesarCipherScreen extends StatefulWidget {
  @override
  _CaesarCipherScreenState createState() => _CaesarCipherScreenState();
}

class _CaesarCipherScreenState extends State<CaesarCipherScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  final TextEditingController shiftController = TextEditingController();
  String encryptedText = '';
  String encryptedText1 = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'App de chiffrement',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, color: Colors.green),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text("Entré vos donnees",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold, fontSize: 30)),
              Text(
                  "Commencez l'expérience de chiffrement de données avec nous.",
                  style: GoogleFonts.montserrat(fontSize: 18)),
              TextField(
                controller: email,
                decoration: InputDecoration(
                    labelText: 'Enter your email',
                    labelStyle: GoogleFonts.poppins(),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100))),
              ),
              Container(
                height: 20,
              ),
              TextField(
                controller: password,
                decoration: InputDecoration(
                    labelText: 'Enter your passwod',
                    labelStyle: GoogleFonts.poppins(),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100))),
              ),
              SizedBox(height: 20),
              TextField(
                controller: shiftController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Enter shift',
                    labelStyle: GoogleFonts.poppins(),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100))),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  String text = email.text;
                  String text2 = password.text;
                  int shift = int.tryParse(shiftController.text) ?? 0;
                  setState(() {
                    encryptedText = CipherUtils.encrypt(text, shift);
                    encryptedText1 = CipherUtils.encrypt(text2, shift);
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: Text(
                  'Encrypt',
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ),
              SizedBox(height: 0),
              ElevatedButton(
                onPressed: () async {
                  String text = email.text;
                  String text2 = password.text;
                  int shift = int.tryParse(shiftController.text) ?? 0;
                  setState(() {
                    encryptedText = CipherUtils.encrypt(text, shift);
                    encryptedText1 = CipherUtils.encrypt(text2, shift);
                  });
                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: encryptedText,
                      password: encryptedText1,
                    );
                    Navigator.of(context).pushReplacementNamed("login");
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: Text(
                  'Signup',
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              ElevatedButton(
                onPressed: () async {
                  String text = email.text;
                  String text2 = password.text;
                  int shift = int.tryParse(shiftController.text) ?? 0;
                  setState(() {
                    encryptedText = CipherUtils.decrypt(text, shift);
                    encryptedText1 = CipherUtils.decrypt(text2, shift);
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: Text(
                  'decrypt',
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ),
              SizedBox(height: 12.0),
              Text(
                'mail crypté : $encryptedText \npassword crypté :  $encryptedText1',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
