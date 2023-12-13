import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:test_sec_inf/button.dart';
import 'package:test_sec_inf/cipherUtils.dart';
import 'package:test_sec_inf/home.dart';
import 'package:test_sec_inf/logo.dart';
import 'package:test_sec_inf/text.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  final TextEditingController shiftController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Customlogo(),
                SizedBox(height: 20),
                Text(
                  "Login",
                  style: GoogleFonts.poppins(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Login to continue using the app",
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 20),
                Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 10),
                CustomTextForm(
                  hinttext: "Enter Your Email",
                  mycontroller: email,
                ),
                SizedBox(height: 10),
                Text(
                  "Password",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5,
                  ),
                ),
                SizedBox(height: 10),
                CustomTextForm(
                  hinttext: "Enter Your password",
                  mycontroller: password,
                ),
                InkWell(
                  onTap: () async {
                    if (email.text == "") {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('email not found'),
                            content: Text('please insert an exesting email'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Ferme la boîte de dialogue
                                },
                                child: Text('Fermer'),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: email.text);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Reset password'),
                          content: Text(
                              'if your email exist , we sended a reset password link'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // Ferme la boîte de dialogue
                              },
                              child: Text('Fermer'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(top: 10, bottom: 20),
                    child: Text(
                      "Forgot password?",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 14, color: Colors.grey[900]),
                    ),
                  ),
                ),
                SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: CustomButton(
                      title: "login",
                      onPressed: () async {
                        try {
                          // Récupération des informations saisies
                          String enteredEmail = email.text;
                          String enteredPassword = password.text;
                          int shift = int.tryParse(shiftController.text) ?? 0;

                          // Tentative de connexion à Firebase avec les informations saisies
                          final userCredential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: CipherUtils.encrypt(enteredEmail, 2),
                            password: CipherUtils.encrypt(enteredPassword, 2),
                          );
                          User? user = FirebaseAuth.instance.currentUser;
                          String cryptedemail =
                              CipherUtils.encrypt(enteredEmail, 2);
                          // Si l'authentification réussit, rediriger vers la page "home"
                          if (user != null && cryptedemail == user.email!) {
                            Navigator.of(context).pushReplacementNamed("home");
                          } else {
                            // Si les identifiants ne correspondent pas
                            print('Identifiants incorrects');
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('Aucun utilisateur trouvé avec cet email.');
                          } else if (e.code == 'wrong-password') {
                            print(
                                'Mot de passe incorrect pour cet utilisateur.');
                          }
                        }
                      },
                    )),
                //SizedBox(height: 10),
                Center(
                  child: Text(
                    "Or login with",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                //SizedBox(height: 0),
                /* Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: MaterialButton(
                        onPressed: () {},
                        child: Image.asset("images/facebook.png"),
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: MaterialButton(
                        onPressed: () {},
                        child: Image.asset("images/google.png"),
                      ),
                    ),
                    SizedBox(width: 20),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: MaterialButton(
                        onPressed: () {},
                        child: Image.asset("images/apple.png"),
                      ),
                    ),
                  ],
                ), */ /* Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: MaterialButton(
                        onPressed: () {},
                        child: Image.asset("images/facebook.png"),
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: MaterialButton(
                        onPressed: () {},
                        child: Image.asset("images/google.png"),
                      ),
                    ),
                    SizedBox(width: 20),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: MaterialButton(
                        onPressed: () {},
                        child: Image.asset("images/apple.png"),
                      ),
                    ),
                  ],
                ), */
                //SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed("signup");
                  },
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "Do you have an account? ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          TextSpan(
                            text: "Register",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
