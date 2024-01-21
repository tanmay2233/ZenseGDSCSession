import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gdsc_app_dev/home.dart';
import 'package:gdsc_app_dev/login.dart';
import 'package:gdsc_app_dev/notesPage.dart';
import 'package:gdsc_app_dev/routes.dart';
import 'package:gdsc_app_dev/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
              theme: ThemeData(
                fontFamily: 'Poppins',
                scaffoldBackgroundColor: const Color(0xFF111111),
              ),
              home: const LoginPage(),
              debugShowCheckedModeBanner: false,
              routes: {
                MyRoutes.loginPageRoute: (context) => const LoginPage(),
                MyRoutes.homePageRoute: (context) => const HomePage(),
                MyRoutes.notesPageRoute: (context) => const NotesPage(),
                MyRoutes.signUpPageRoute: (context) => const SignupPage()
            },  
              initialRoute: MyRoutes.loginPageRoute,
            );
        });
  }
}
