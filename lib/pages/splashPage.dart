import 'dart:async';
import 'package:ferry_booking/database/ferrytickets_helper.dart';
import 'package:ferry_booking/pages/login_screen.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';
import '../theme/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPage createState() => _SplashPage();
}

class _SplashPage extends State<SplashPage> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const LoginPage(title: 'title')));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 350,
              height: 350,
              margin: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/getter1.png'),
                      fit: BoxFit.cover,
                      )
              ),
            ),

            Text(
              'Water Space',
              style: whiteTextStyle.copyWith(
                  fontSize: 40, fontWeight: FontWeight.w500, letterSpacing: 1, color: Color.fromARGB(255, 1, 85, 57),
                  )
            ),
          ],
        ),
      ),
    );
  }
}
