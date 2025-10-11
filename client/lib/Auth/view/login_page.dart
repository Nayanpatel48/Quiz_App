import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repradar/Auth/model/user_login_model.dart';
import 'package:repradar/Auth/view/signup_page.dart';
import 'package:repradar/Auth/view/widgets/loading_indicator.dart';
import 'package:repradar/Auth/viewmodel/auth_view_model.dart';
import 'package:repradar/Home/view/home_page.dart';

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

                  //--------
                  vm.isLoading
                      ? LoadingIndicator()
                      : ElevatedButton(
                          onPressed: () async {
                            // create login user model
                            final newUserLogin = UserLoginModel(
                              email: emailTextfieldController.text,
                              password: passwordTextfieldController.text,
                            );

                            //now log in the user using viewmodel
                            await vm.loginUser(newUserLogin);

                            //check if the user is logged in or not for showing messgae
                            String message = vm.isUserLoggedIn
                                ? 'Login successfull!'
                                : vm.errorMessage;

                            //show the snackbar
                            ScaffoldMessenger.of(
                              // ignore: use_build_context_synchronously
                              context,
                            ).showSnackBar(SnackBar(content: Text(message)));

                            void redirectHome() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const HomePage(),
                                ),
                              );
                            }

                            // after successful login redirect user to the homepage
                            if (vm.isUserLoggedIn) {
                              redirectHome();
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
