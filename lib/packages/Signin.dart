import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lostfound/main.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lostfound/packages/Signup.dart';
import 'package:lostfound/packages/forgotpassword.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(const SignIn());
}

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/signup': (context) => SignUp(),
        '/passreset': (context) => PasswReset(),
      },
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(body: ListView(children: [Sign()])),
    );
  }
}

class Sign extends StatefulWidget {
  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Future<void> _signInUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Veuillez remplir tous les champs.")),
      );
      return;
    }

    try {
      // Tente la connexion
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Si la connexion réussit, on peut naviguer vers un écran “home” ou autre
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Connexion réussie !")));

      // Exemple de navigation : remplacer l'écran actuel par un écran home
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => HomePage()), // Votre HomePage
      // );
    } on FirebaseAuthException catch (e) {
      // Erreurs Firebase courantes (mauvais mot de passe, email inexistant, etc.)
      String message;
      if (e.code == 'user-not-found') {
        message = "Utilisateur introuvable. Veuillez créer un compte.";
      } else if (e.code == 'wrong-password') {
        message = "Mot de passe incorrect.";
      } else {
        message = "Erreur: ${e.message}";
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      // Autres erreurs
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erreur inattendue: $e")));
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
                    '9:30',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              // BOUTON "Sign In"
              Positioned(
                left: 34,
                top: 748,
                child: GestureDetector(
                  onTap: () {
                    // Appel de la méthode pour se connecter
                    _signInUser();
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
                left: 162,
                top: 763,
                child: GestureDetector(
                  onTap: () {
                    // Appel de la méthode pour se connecter
                    _signInUser();
                  },
                  child: Text(
                    'Sign In ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFFAD6405),
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 34,
                top: 490,
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
              // -- Champ email --
              Positioned(
                left: 50,
                top: 495,
                child: SizedBox(
                  width: 290,
                  height: 50,
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.black87, fontSize: 16),
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

              Positioned(
                left: 35,
                top: 557,
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
              // -- Champ password --
              Positioned(
                left: 50,
                top: 562,
                child: SizedBox(
                  width: 290,
                  height: 40,
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(color: Colors.black54),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 160,
                top: 650,
                child: SvgPicture.asset(
                  'assets/facebookk.svg',
                  width: 32,
                  height: 32,
                ),
              ),
              Positioned(
                left: 40,
                top: 620,
                child: Text(
                  '----------------------- Or Sign in with -----------------------',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color.fromARGB(255, 24, 23, 23),
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
              Positioned(
                left: 225,
                top: 654,
                child: SvgPicture.asset(
                  'assets/google.svg',
                  width: 25,
                  height: 25,
                ),
              ),
              Positioned(
                left: 45,
                top: 710,
                child: Icon(
                  Icons.check_circle,
                  size: 20,
                  color: CupertinoColors.systemYellow,
                ),
              ),
              Positioned(
                left: 70,
                top: 710,
                child: Text(
                  'Remember me',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color.fromARGB(255, 24, 23, 23),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
              Positioned(
                left: 40,
                top: 820,
                child: Text(
                  "Don't have an account ? ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color.fromARGB(255, 24, 23, 23),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Positioned(
                left: 200,
                top: 820,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text(
                    "SignUp ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 240,
                top: 710,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => PasswReset()),
                    );
                  },
                  child: Text(
                    'Forgot Password ? ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 13, 1, 85),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 113,
                top: 266,
                child: Container(
                  width: 167,
                  height: 145,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(),
                ),
              ),
              Positioned(
                left: 3,
                top: 167,
                child: SizedBox(
                  width: 387,
                  child: Column(
                    children: [
                      Text(
                        'Welcome Back ! ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 36,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 5),

                      Text(
                        'Login to access you account ! ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 24, 23, 23),
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: 5),
                      Image.asset('assets/signin.jpg'),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 37,
                top: 671,
                child: Container(width: 16, height: 16, child: Stack()),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
