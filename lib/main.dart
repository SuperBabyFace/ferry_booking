import 'package:ferry_booking/pages/login_screen.dart';
import 'package:ferry_booking/pages/splashPage.dart';
import 'package:flutter/material.dart';
import '../pages/login_screen.dart';
import '../database/userSession.dart';
import '../widgets/bottomNavigationbar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await userSaveSession.init();
  runApp(const MyApp());
}

ColorScheme defaultColorScheme = const ColorScheme(
  primary: Color.fromARGB(255, 32, 102, 75),
  secondary: Color(0xff03DAC6),
  surface: Color.fromARGB(255, 0, 0, 0),
  background: Color.fromARGB(255, 255, 255, 255),
  error: Color(0xffCF6679),
  onPrimary: Color(0xff000000),
  onSecondary: Color(0xff000000),
  onSurface: Color(0xffffffff),
  onBackground: Color(0xffffffff),
  onError: Color(0xff000000),
  brightness: Brightness.light,
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    theme:
    ThemeData(
      colorScheme: defaultColorScheme,
      brightness: Brightness.light,
      // primarySwatch: Colors.red,
    );
    return MaterialApp(debugShowCheckedModeBanner: false, routes: {
      '/': (context) => SplashPage(),
      '/get-started': (context) => LoginPage(
            title: '',
          ),
      // '/sign-up': (context) => SignUpPage(),
      // '/bonus': (context) => BonusPage(),
      // '/main': (context) => MainPage(),
      // '/sign-in': (context) => SignInPage(),
    });
  }
}

// Widget build(BuildContext context) {
//   return MaterialApp(
//     title: 'Flutter Demo',
//     theme: ThemeData(
//       colorScheme: defaultColorScheme,
//       // brightness: Brightness.light,
//       primarySwatch: Colors.blue,
//     ),
//     home: const LoginPage(title: 'Login UI'),
//   );
// }
