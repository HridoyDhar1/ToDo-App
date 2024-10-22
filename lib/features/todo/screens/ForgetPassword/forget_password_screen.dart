import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart'; // Make sure you import this package
import 'package:otp_text_field/style.dart';
import 'package:todoapp/common/wigets/elevatedbutton/custom_elevatedbutton.dart';
import 'package:todoapp/features/todo/screens/HomeScreen/home_screen.dart';    // Import for field style

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              const Text(
                "We’ve \nsent you an email with your code",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 15, color: Colors.black), // Default style for the text
                  children: <TextSpan>[
                    TextSpan(text: 'Enter your code which has been sent to your email, please check it '),
                    TextSpan(
                      text: 'support@gmail.com',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black), // Custom style for the email
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              OTPTextField(
                length: 5,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 50,
                style: const TextStyle(
                  fontSize: 17,
                ),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.box,
                onCompleted: (pin) {
                  print("Completed: " + pin);
                },
              ),
              const SizedBox(height: 50),
              Center(child: CustomElevatedbutton(hSize: 150, vSize: 15, onPressed: _verificationPin, name: "Verify" ,textColor: Colors.white)),
              const SizedBox(height: 50),
              Center(
                child: RichText(text: const TextSpan(style: TextStyle(fontSize: 15,color: Colors.black),children: [
                  TextSpan(text: "Don't recived code? "),
                  TextSpan(text: "Resend",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold))
                ])),
              )
            ],
          ),
        ),
      ),
    );
  }
  void _verificationPin(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const HomeScreen()));
  }
}
