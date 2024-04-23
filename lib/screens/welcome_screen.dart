import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  const WelcomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(
        seconds: 1,
      ),
      vsync: this,
    );
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    // animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
    // animation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse(from: 1.0);
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    // });
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Hero(
                      tag: "logo",
                      child: SizedBox(
                        height: 60.0,
                        child: Image.asset('images/logo.png'),
                      ),
                    ),
                    AnimatedTextKit(
                      // repeatForever: true,
                      // totalRepeatCount: 2,
                      animatedTexts: [
                        TyperAnimatedText(
                          'Flash Chat',
                          textStyle: const TextStyle(
                            fontSize: 45.0,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                          speed: const Duration(milliseconds: 200),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 48.0,
                ),
                RoundedButton(
                  title: "Login",
                  colour: Colors.lightBlueAccent,
                  onPressed: () {
                    Navigator.of(context).pushNamed(LoginScreen.id);
                  },
                ),
                RoundedButton(
                  title: "Register",
                  colour: Colors.blueAccent,
                  onPressed: () {
                    Navigator.of(context).pushNamed(RegistrationScreen.id);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
