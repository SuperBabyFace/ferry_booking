import 'package:flutter/material.dart';
import 'register_screen.dart';

import '../database/ferrytickets_helper.dart';
import '../models/user.dart';
import '../theme/theme.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
   final FerryTicketDatabase _ferryTicketDatabase = FerryTicketDatabase();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kWhiteColor,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
            Container(height: 0.5),

            Text (
              'Water Space',
              style: whiteTextStyle.copyWith(
                  fontSize: 30, fontWeight: FontWeight.w500, letterSpacing: 1, color: Color.fromARGB(255, 1, 85, 57),
              ),
            ),
            
            Image.asset('assets/getter1.png',
            fit: BoxFit.cover
            ),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: usernameController,
                    validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Username';
                            }
                            return null;
                          },
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Enter your username',
                      prefixIcon: const Icon(Icons.person_outline_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    maxLines: 1,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account yet?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const RegisterPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Create an account',
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_formKey.currentState!.validate()) {
                          User user = User (
                            username: usernameController.text,
                            password: passwordController.text);
                          _ferryTicketDatabase.userLogin(user, context);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                    ),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
