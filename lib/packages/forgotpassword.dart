import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Par exemple, on retourne à SignIn après l'envoi de l'e-mail
import 'package:lostfound/packages/Signin.dart';

void main() {
  runApp(const PasswReset());
}

// Cette classe gère l'app MaterialApp.
// Vous pouvez l'adapter selon votre structure.
class PasswReset extends StatelessWidget {
  const PasswReset({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Plus besoin de /verify si on utilise le lien de reset de Firebase
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(
          children: [
            Passwreset(), // Notre UI ci-dessous
          ],
        ),
      ),
    );
  }
}

// UI de la page "Forgot Password"
class Passwreset extends StatelessWidget {
  final TextEditingController _forgotpassword = TextEditingController();

  // Méthode pour envoyer l'e-mail de réinitialisation
  Future<void> _sendResetEmail(BuildContext context) async {
    final email = _forgotpassword.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Veuillez saisir votre e-mail.")));
      return;
    }

    try {
      // Appel Firebase pour envoyer le lien de réinitialisation
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      // Succès : on informe l'utilisateur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Un lien de réinitialisation a été envoyé à $email. Consultez votre boîte mail.",
          ),
        ),
      );

      // Option : revenir à la page de connexion
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignIn()),
      );
    } on FirebaseAuthException catch (e) {
      // Erreurs possibles : email invalide, email non trouvé, etc.
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erreur : ${e.message}")));
    } catch (e) {
      // Autres erreurs
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erreur inattendue : $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 393,
          height: 852,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: const Color(0xFFFFF3D9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Stack(
            children: [
              // ---- Vos décorations existantes ----
              Positioned(
                left: -103,
                top: -64,
                child: Container(
                  width: 210,
                  height: 245,
                  decoration: ShapeDecoration(
                    color: const Color(0x5EF4B908),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: -105,
                child: Container(
                  width: 180,
                  height: 227,
                  decoration: ShapeDecoration(
                    color: const Color(0x49F5BA09),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 39,
                top: 14,
                child: SizedBox(
                  width: 79,
                  child: Text(
                    '9:45',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              // ---- Bouton "Next" modifié pour appeler _sendResetEmail ----
              Positioned(
                left: 34,
                top: 708,
                child: GestureDetector(
                  onTap: () {
                    _sendResetEmail(context);
                  },
                  child: Container(
                    width: 325,
                    height: 60,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFCE29D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                left: 172,
                top: 723,
                child: Text(
                  'Next',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFAD6405),
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              // ---- Champ email ----
              Positioned(
                left: 37,
                top: 417,
                child: Container(
                  width: 325,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFFFCF6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 112,
                top: 417,
                child: SizedBox(
                  width: 290,
                  height: 50,
                  child: TextFormField(
                    controller: _forgotpassword,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Colors.black87, // Texte saisi en foncé
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(color: Colors.black54),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ),

              // ---- Titres / Textes ----
              Positioned(
                left: 10,
                top: 232,
                child: SizedBox(
                  width: 387,
                  child: Text(
                    'Forgot Password !',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 36,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 62,
                top: 291,
                child: Text(
                  'Enter your email to receive a password\nreset link',
                  style: TextStyle(
                    color: Colors.black.withAlpha(97),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
