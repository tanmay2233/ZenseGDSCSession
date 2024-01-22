import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gdsc_app_dev/routes.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String email = '';
  String password = '';
  String name = '';

  Future signUp() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      Navigator.pushNamed(context, MyRoutes.homePageRoute);
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message!),
      ));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Okay',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(50),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: 'Noted',
                      style: TextStyle(
                        color: const Color(0xFF7973FF),
                        fontSize: ScreenUtil().setSp(50),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(40),
              ),
              InputBox("Name", TextInputType.name),
              InputBox("Email ID", TextInputType.emailAddress),
              InputBox("Password", TextInputType.text),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              ElevatedButton(
                onPressed: signUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                      0xFF7973FF), // Set the background color to purple
                  foregroundColor: Colors.white, // Set the text color to white
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 8),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize:
                          ScreenUtil().setSp(24), // Set the text size to 20.0
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Have an account?",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(14),
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const Signup()));
                      Navigator.pushNamed(context, MyRoutes.loginPageRoute);
                    },
                    child: Text(
                      " Login here",
                      style: TextStyle(
                          color: const Color(0xFF7973FF),
                          fontSize: ScreenUtil().setSp(16),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5),
                    ),
                  )
                ],
              ),
            ]),
      ),
    );
  }

  Column InputBox(title, keyboardType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // InputTitle(title),
        SizedBox(
          width: ScreenUtil().setWidth(356),
          height: ScreenUtil().setHeight(54),
          child: TextField(
            obscureText: title == "Password" ? true : false,
            onChanged: (value) {
              if (title == 'Password') {
                password = value;
              } else if (title == 'Email ID') {
                email = value;
              } else if (title == 'Name') {
                name = value;
              }
            },
            autocorrect: false,
            textAlignVertical: TextAlignVertical.center,
            keyboardType: keyboardType,
            style: const TextStyle(
                fontWeight: FontWeight.w400, color: Colors.white),
            decoration: InputDecoration(
                hintText: title,
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1.15, color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(12)))),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(20),
        ),
      ],
    );
  }
}
