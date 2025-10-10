import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repradar/Auth/view/signup_page.dart';
import 'package:repradar/Auth/viewmodel/auth_view_model.dart';

class LoginPage extends StatefulWidget {
  // constructor
  const LoginPage({super.key});

  // "Hey Flutter, when you build this LoginScreen, create and attach its 'brain',
  // which is called _LoginScreenState."
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //controllers for storing input field text
  final emailTextfieldController = TextEditingController();
  final passwordTextfieldController = TextEditingController();

  // "When this screen is permanently gone, clean up the text field controllers to prevent memory leaks."
  @override
  void dispose() {
    super.dispose();
    emailTextfieldController.dispose();
    passwordTextfieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Page')),

      //----------
      body: ChangeNotifierProvider(
        create: (_) => AuthViewModel(),
        child: Consumer<AuthViewModel>(
          builder: (context, vm, _) {
            return Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //-------------
                  TextField(
                    controller: emailTextfieldController,
                    decoration: const InputDecoration(label: Text('email')),
                  ),

                  //--------------
                  TextField(
                    controller: passwordTextfieldController,
                    decoration: const InputDecoration(label: Text('Password')),
                  ),

                  //--------------
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignUpPage()),
                    ),
                    child: const Text('Do not have an acount? sing up'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
