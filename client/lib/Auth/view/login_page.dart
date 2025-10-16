import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repradar/Auth/model/user_login_model.dart';
import 'package:repradar/Auth/view/signup_page.dart';
import 'package:repradar/Auth/view/widgets/loading_indicator.dart';
import 'package:repradar/Auth/viewmodel/auth_view_model.dart';
import 'package:repradar/Home/view/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextfieldController = TextEditingController();
  final passwordTextfieldController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailTextfieldController.dispose();
    passwordTextfieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => AuthViewModel(),
        child: Consumer<AuthViewModel>(
          builder: (context, vm, _) {
            return Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: emailTextfieldController,
                    decoration: const InputDecoration(label: Text('email')),
                  ),

                  TextField(
                    controller: passwordTextfieldController,
                    decoration: const InputDecoration(label: Text('Password')),
                  ),

                  vm.isLoading
                      ? LoadingIndicator()
                      : ElevatedButton(
                          onPressed: () async {
                            final newUserLogin = UserLoginModel(
                              email: emailTextfieldController.text,
                              password: passwordTextfieldController.text,
                            );

                            await vm.loginUser(newUserLogin);

                            String message = vm.isUserLoggedIn
                                ? 'Login successfull!'
                                : vm.errorMessage;

                            ScaffoldMessenger.of(
                              // ignore: use_build_context_synchronously
                              context,
                            ).showSnackBar(SnackBar(content: Text(message)));

                            void redirectMainPage() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const MainPage(),
                                ),
                              );
                            }

                            // after successful login redirect user to the homepage
                            if (vm.isUserLoggedIn) {
                              redirectMainPage();
                            }
                          },
                          child: const Text('Login'),
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
