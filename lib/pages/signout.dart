import 'package:ferry_booking/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../database/userSession.dart';
import '../widgets/custombutton.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);
  
Future<void> logoutUser(BuildContext context) async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs?.clear();
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginPage(
                              title: '',
                            )));
              }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: CustomButton(
            title: 'Sign Out',
            onPressed: () {
              logoutUser(context);
            }),
      ),
    );
  }
}
