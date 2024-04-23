import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;
  final _auth = FirebaseAuth.instance;
  String? email;
  String? password;
  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: "logo",
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                const SizedBox(
                  height: 48.0,
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFeildDecoration.copyWith(
                    label: const Text("Email"),
                    hintText: "Enter Your Email",
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: _obscureText,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFeildDecoration.copyWith(
                    label: const Text("Password"),
                    hintText: "Enter Your Password",
                    prefixIcon: const Icon(Icons.password),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Container(
                  child: !_isLoading
                      ? RoundedButton(
                          title: "Login",
                          colour: Colors.lightBlueAccent,
                          onPressed: () async {
                            try {
                              setState(() {
                                _isLoading = true;
                              });
                              await _auth.signInWithEmailAndPassword(
                                  email: email!, password: password!);
                              setState(() {
                                _isLoading = false;
                              });
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pushNamed(ChatScreen.id);
                            } catch (e) {
                              print(e);
                            }
                          },
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
