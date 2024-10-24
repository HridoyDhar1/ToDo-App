// ignore_for_file: override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:todoapp/common/wigets/elevatedbutton/custom_elevatedbutton.dart';
import 'package:todoapp/features/authentication/controller/auth_controller.dart';
import 'package:todoapp/features/todo/screens/LoginScreen/login_screen.dart';
import 'package:todoapp/features/todo/screens/SingupScreen/singup_screen.dart';
import 'package:todoapp/features/todo/screens/SplashScreen/widgets/splash_screen_title.dart';
import 'package:todoapp/utils/constants/text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override 
  void initstate(){
    super.initState();
    _singIn();
  }
    Future<void>_singIn()async{
    await  Future.delayed(const Duration(seconds: 2));
    await AuthController.getAccessToken();
    if(AuthController.isLoggedIn()){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
    }else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SplashScreen()));
    }

  }
  void _singup(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const SingupScreen() ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/images/splash.png"),
          ),
          const SplashScreenTitle(),
          const SizedBox(height: 20),
          Text(
            Texts.SplashScreenSubTitle,
            style: const TextStyle(fontSize: 15),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             CustomElevatedbutton(hSize: 60, vSize: 15, onPressed:_singIn, name: "Sing In", textColor: Colors.white),
              const SizedBox(width: 20),
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: _singup,
                  child: const Text(
                    "Sing Up",
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          )
        ],
      ),
    );
  }



}
