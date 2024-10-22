import 'package:flutter/material.dart';
import 'package:todoapp/common/wigets/circularprogress/circular_progress.dart';
import 'package:todoapp/common/wigets/elevatedbutton/custom_elevatedbutton.dart';
import 'package:todoapp/common/wigets/loginpage/from_divider.dart';
import 'package:todoapp/common/wigets/loginpage/social_buttons.dart';
import 'package:todoapp/data/models/network_response.dart';
import 'package:todoapp/data/services/network_call.dart';

import 'package:todoapp/features/todo/screens/LoginScreen/widgets/text_fields.dart';
import 'package:todoapp/utils/url/urls.dart';

class SingupScreen extends StatefulWidget {
  const SingupScreen({super.key});

  @override
  State<SingupScreen> createState() => _SingupScreenState();
}

class _SingupScreenState extends State<SingupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nAmeController = TextEditingController();
  final TextEditingController eMailController = TextEditingController();
  final TextEditingController pAssworController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _isProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                  "Create Account",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                    controller: nAmeController,
                    name: "Full Name",
                    keyboardTypes: TextInputType.text,
                    icons: Icons.person,
                    valid: 'Enter the name'),
                const SizedBox(height: 20),
                CustomTextField(
                    controller: eMailController,
                    valid: 'Enter valid email',
                    name: "Email",
                    keyboardTypes: TextInputType.text,
                    icons: Icons.email),
                const SizedBox(height: 20),
                CustomTextField(
                    valid: 'Enter the password',
                    controller: pAssworController,
                    name: "Password",
                    keyboardTypes: TextInputType.text,
                    icons: Icons.lock),
                const SizedBox(height: 20),
                CustomTextField(
                    valid: 'Enter the password',
                    controller: confirmPasswordController,
                    name: "Confirm Password",
                    keyboardTypes: TextInputType.text,
                    icons: Icons.lock),
                const SizedBox(height: 30),
                Center(
                    child: Visibility(
                        visible: !_isProgress,
                        replacement: const CircularProgresss(),
                        child: CustomElevatedbutton(
                            hSize: 150,
                            vSize: 15,
                            onPressed: _homepage,
                            name: "Sing Up",
                            textColor: Colors.white))),
                const SizedBox(height: 30),
                const FromDivider(),
                const SizedBox(height: 30),
                const SocialButtons()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _homepage() {
    if (_formKey.currentState!.validate() ) {
      _singup();
    }
  }

  Future<void> _singup() async {
    _isProgress = true;
    setState(() {});

    _isProgress = false;
    setState(() {});
    Map<String, dynamic> resquestBody = {
      'email': eMailController.text.trim(),
      'fullname': nAmeController.text.trim(),
      'password': pAssworController.text.trim(),
    };
    NetworkResponse response = await NetworkCall.postRequest(
        url: Urls.resgistration, body: resquestBody);
    if (response.isSuccess) {
      _clearTextFields();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('New user created')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.errorMessage)));
    }
  }

  void _clearTextFields() {
    eMailController.clear();
    pAssworController.clear();
    nAmeController.clear();
  }

  @override
  void dispose() {
    eMailController.dispose();
    nAmeController.dispose();
    pAssworController.dispose();
    super.dispose();
  }
}
