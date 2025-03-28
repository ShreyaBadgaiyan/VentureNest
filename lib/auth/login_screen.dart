import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/auth/signup_screen.dart';
import 'package:ui/auth/utils/utils.dart';
import 'package:ui/entrepreneur_screens/bottomnavbar.dart';
import 'package:ui/investor_screens/ibottomnavigationbar.dart';
import 'clipper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool _obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget _buildEmail() {
    return Container(
      height: 50,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          offset: const Offset(3, 3),
          blurRadius: 6,
          color: Colors.grey.shade400,
        )
      ]),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Enter your email';
          }
          return null;
        },
        controller: emailController,
        decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(Icons.email),
            hintText: 'Enter your email'),
      ),
    );
  }

  Widget _buildPassword() {
    return Container(
      height: 50,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          offset: const Offset(3, 3),
          blurRadius: 6,
          color: Colors.grey.shade400,
        )
      ]),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Enter your password';
          }
          return null;
        },
        obscureText: _obscurePassword,
        controller: passwordController,
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(top: 14),
            prefixIcon: const Icon(Icons.lock_outline_rounded),
            hintText: 'Enter your password',
            suffixIcon: IconButton(
              icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            )),
      ),
    );
  }

  void _loginUser(String role) async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('role', role);

      _auth
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((value) {
        final uid = value.user!.uid;

        if (role == 'entrepreneur') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => NavigationMenu(uid: uid),
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => INavigationMenu(uid: uid),
            ),
          );
        }
      }).catchError((error) {
        debugPrint(error.toString());
        Utils().toastMessage(error.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(children: [
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 300),
              painter: RPSCustomPainter(),
            ),
            Positioned(
              top: 16,
              right: -5,
              child: CustomPaint(
                size: Size(MediaQuery.of(context).size.width, 300),
                painter: PSCustomPainter(),
              ),
            ),
            const Positioned(
                top: 220,
                left: 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 26),
                    ),
                    Text(
                      'Please sign in to continue',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
                    )
                  ],
                ))
          ]),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 25),
                  _buildEmail(),
                  const SizedBox(height: 25),
                  _buildPassword(),
                  const SizedBox(height: 25),
                  const Text('FORGET',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 32, 172, 130),
                      )),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      InkWell(
                        onTap: () => _loginUser('entrepreneur'),
                        child: Container(
                          height: 50,
                          width: 160,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: const LinearGradient(colors: [
                                Color.fromARGB(255, 32, 172, 130),
                                Color(0xFF0AD98D),
                              ])),
                          child: const Row(
                            children: [
                              SizedBox(width: 10),
                              Text(
                                "Entrepreneur",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    color: Colors.white),
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.arrow_forward, color: Colors.white)
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () => _loginUser('investor'),
                        child: Container(
                          height: 50,
                          width: 140,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: const LinearGradient(colors: [
                                Color.fromARGB(255, 32, 172, 130),
                                Color(0xFF0AD98D),
                              ])),
                          child: const Row(
                            children: [
                              SizedBox(width: 20),
                              Text(
                                "Investor",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    color: Colors.white),
                              ),
                              SizedBox(width: 20),
                              Icon(Icons.arrow_forward, color: Colors.white)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 150),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don’t have an account? ",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const SignUpScreen()));
                          },
                          child: const Text("Sign Up",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 32, 172, 130),
                              )))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
