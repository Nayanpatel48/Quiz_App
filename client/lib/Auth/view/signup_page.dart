import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repradar/Auth/view/login_page.dart';
import 'package:repradar/Auth/viewmodel/auth_view_model.dart';

class SignUpPage extends StatefulWidget {
  //constructor
  const SignUpPage({super.key});

  // "Hey Flutter, when you build this LoginScreen, create and attach its 'brain',
  // which is called _LoginScreenState."
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //for storing text from text fields
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  // "When this screen is permanently gone, clean up the text field controllers to prevent memory leaks."
  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SignUp')),
      body: ChangeNotifierProvider(
        create: (_) => AuthViewModel(),
        child: Consumer<AuthViewModel>(
          builder: (context, vm, _) {
            return Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //--------------------
                  TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(label: Text('Username')),
                  ),

                  //--------------
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(label: Text('Email')),
                  ),

                  //-------------
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(label: Text('Password')),
                  ),

                  //--------------
                  const SizedBox(height: 16),

                  //--------------
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                    ),
                    child: const Text('Already have an account? Login'),
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
