import 'package:agenda_app/screens/login/widgets/email_field.dart';
import 'package:agenda_app/screens/login/widgets/get_started_button.dart';
import 'package:agenda_app/screens/login/widgets/password_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late TextEditingController emailController;
  late TextEditingController passwordController;

  bool loadingBallAppear = false;
  double _elementsOpacity = 1;

  @override
  void initState() {

    emailController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 70),
                      TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 300),
                        tween: Tween(begin: 1, end: _elementsOpacity),
                        builder: (_, value, __) => Opacity(
                          opacity: value,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 25),
                              Text(
                                "Inicio de Sesión",
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                  fontSize: 35),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      EmailField(
                          fadeEmail: _elementsOpacity == 0,
                          emailController: emailController),
                      const SizedBox(height: 40),
                      PasswordField(
                          fadePassword: _elementsOpacity == 0,
                          passwordController: passwordController),
                      const SizedBox(height: 50),
                      GetStartedButton(
                        elementsOpacity: _elementsOpacity,
                        onTap: () {
                          setState(() {
                            _elementsOpacity = 0;
                          });
                        },
                        onAnimatinoEnd: () async {
                          await Future.delayed(
                              Duration(milliseconds: 500));
                          setState(() {
                            loadingBallAppear = true;
                          });
                        },
                      )
                    ],
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