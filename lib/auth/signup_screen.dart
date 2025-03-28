import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ui/auth/clipper.dart';
import 'package:ui/auth/login_screen.dart';
import 'package:ui/auth/utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  // var confirmPasswordController = TextEditingController();

//Firebase auth initialization

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget _buildEmail() {
    return Container(
      height: 50,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          offset: Offset(3, 3),
          blurRadius: 6,
          color: Colors.grey.shade400,
        )
      ]),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Enter your email';
          }
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
          offset: Offset(3, 3),
          blurRadius: 6,
          color: Colors.grey.shade400,
        )
      ]),
      child: TextFormField(
        obscureText: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Enter your password';
          }
        },
        controller: passwordController,
        decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(Icons.lock_clock_outlined),
            hintText: 'Enter your password'),
      ),
    );
  }

//
  Widget _buildConfirmPassword() {
    return Container(
      height: 50,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          offset: Offset(3, 3),
          blurRadius: 6,
          color: Colors.grey.shade400,
        )
      ]),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Enter your password again';
          }
        },
        // controller: confirmPasswordController,
        decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(Icons.lock_clock_outlined),
            hintText: 'Enter your password again'),
      ),
    );
  }

  Widget _buildName() {
    return Container(
      height: 50,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          offset: Offset(3, 3),
          blurRadius: 6,
          color: Colors.grey.shade400,
        )
      ]),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Enter your name';
          }
        },
        controller: nameController,
        decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(Icons.person),
            hintText: 'Enter your name'),
      ),
    );
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
                      'Sign Up',
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
            padding: EdgeInsets.symmetric(horizontal: 28),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 20),
                  _buildName(),
                  const SizedBox(height: 20),
                  _buildEmail(),

                  const SizedBox(height: 20),
                  _buildPassword(),
                  const SizedBox(height: 20),
                  // _buildConfirmPassword(),
                  // const SizedBox(height: 25),
                  // const Text('FORGET',
                  //     style: TextStyle(
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.w500,
                  //       color: Color(0xfff7b858),
                  //     )),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _auth
                            .createUserWithEmailAndPassword(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim())
                            .then((value) {
                          // Navigate to Home or show success message
                          Utils().toastMessage('User registered successfully!');
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        }).onError((error, stackTrace) {
                          Utils().toastMessage(error.toString());
                        });
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(colors: [
                            Color.fromARGB(255, 32, 172, 130),
                            Color(0xFF0AD98D),
                          ])),
                      child: const Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "SIGN UP",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(Icons.arrow_forward, color: Colors.white)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
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
                                    builder: (_) => LoginScreen()));
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 32, 172, 130),
                            ),
                          ))
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
