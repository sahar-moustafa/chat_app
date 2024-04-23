import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'chat_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  const RegistrationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
                        _obscureText ? Icons.visibility : Icons.visibility_off,
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
                          title: "Register",
                          colour: Colors.blueAccent,
                          onPressed: () async {
                            try {
                              setState(() {
                                _isLoading = true;
                              });
                              await _auth.createUserWithEmailAndPassword(
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
