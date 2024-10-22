import 'package:flutter/material.dart';
import 'package:todoapp/common/wigets/circularprogress/circular_progress.dart';
import 'package:todoapp/common/wigets/elevatedbutton/custom_elevatedbutton.dart';
import 'package:todoapp/common/wigets/loginpage/from_divider.dart';
import 'package:todoapp/common/wigets/loginpage/social_buttons.dart';
import 'package:todoapp/common/wigets/snackbar/snack_bar.dart';
import 'package:todoapp/data/models/network_response.dart';
import 'package:todoapp/data/services/network_call.dart';
import 'package:todoapp/features/authentication/controller/auth_controller.dart';
import 'package:todoapp/features/todo/screens/ForgetPassword/forget_password_screen.dart';

import 'package:todoapp/features/todo/screens/HomeScreen/home_screen.dart';

import 'package:todoapp/features/todo/screens/LoginScreen/widgets/text_fields.dart';
import 'package:todoapp/features/todo/screens/SingupScreen/singup_screen.dart';

import 'package:todoapp/utils/url/urls.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isProgress=false;
  final GlobalKey<FormState>_formKey=GlobalKey();
  final TextEditingController emailsController=TextEditingController();
  final TextEditingController passwordsController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                const Text(
                  "Hey,",
                  style: TextStyle(fontSize: 30),
                ),
                const Text(
                  "Welcome Back!",
                  style: TextStyle(fontSize: 30, color: Colors.grey),
                ),
                const SizedBox(height: 50),
                Column(
                  children: [
              CustomTextField(
                      controller:emailsController ,
                        name: 'Email',
                        keyboardTypes: TextInputType.text,
                        icons: Icons.email, valid: 'Enter valid email',),
                    const SizedBox(height: 10),
                    CustomTextField(
                      
                      controller: passwordsController,
                        name: 'Password',
                        keyboardTypes: TextInputType.text,
                        icons: Icons.lock, valid: 'Enter correct password',),
                    const SizedBox(height: 10),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed:_forgetPassowrd,
                          child: const Text(
                            "Forget password?",
                            style: TextStyle(color: Colors.red),
                          ),
                        )),
                    const SizedBox(height: 10),
                    Center(
                        child: Visibility(
                          visible: !_isProgress,
                          replacement: const CircularProgresss(),
                          child: CustomElevatedbutton(
                              hSize: 150,
                              vSize: 15,
                              onPressed: _singin,
                              name: "Sing In",
                              textColor: Colors.white),
                        )),
                  ],
                ),
                const SizedBox(height: 20),
                const FromDivider(),
                const SizedBox(height: 20),
                const SocialButtons(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Haven't sinup yet?"),
                    TextButton(
                        onPressed: _createAccount,
                        child: const Text(
                          "Create Account",
                          style: TextStyle(color: Colors.blue),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
// singin
  void _singin() {
    if(_formKey.currentState!.validate()){
_singIn();
    }

    
  }
Future<void>_singIn()async{
  _isProgress=true;
  setState(() {
    
  });
  Map<String,dynamic>resquestBody={
    'email':emailsController.text.trim(),
    'password':passwordsController.text
  };
  final  NetworkResponse response=await NetworkCall.postRequest(url: Urls.login,body: resquestBody);
  _isProgress=false;setState(() {
    
  });
  if(response.isSuccess){
    await AuthController.saveAccessToken(response.responseData['token']);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const HomeScreen()),(value)=>false);
  }
  else{
    showSnackBarMessage(context, response.errorMessage,true);
  }
}
// Create Account //
  void _createAccount() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SingupScreen()));
  }
  // Forget Password //
  void _forgetPassowrd(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> const ForgetPasswordScreen()));
  }
}
