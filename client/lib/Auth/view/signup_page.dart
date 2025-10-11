import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:repradar/Auth/model/user_login_model.dart';
import 'package:repradar/Auth/model/user_model.dart';
import 'package:repradar/Auth/view/login_page.dart';
import 'package:repradar/Auth/view/widgets/loading_indicator.dart';
import 'package:repradar/Auth/viewmodel/auth_view_model.dart';
import 'package:repradar/Home/view/home_page.dart';

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
      appBar: AppBar(title: const Text('SignUp Page')),
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
                  vm.isLoading
                      ? LoadingIndicator()
                      : ElevatedButton(
                          onPressed: () async {
                            // as soon as button is pressed create an user object
                            final newUser = User(
                              username: usernameController.text,
                              email: emailController.text,
                              hashedPassword: passwordController.text,
                            );

                            // pass newly created user object to the view model function
                            await vm.createUser(newUser);

                            // checking if the user is created successfully or not
                            String message = vm.isUserCreated
                                ? 'Account created successfully!'
                                : vm.errorMessage;

                            // show the snack bar
                            ScaffoldMessenger.of(
                              // ignore: use_build_context_synchronously
                              context,
                            ).showSnackBar(SnackBar(content: Text(message)));

                            // now since user is created we can login them directly

                            await vm.loginUser(
                              UserLoginModel(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );

                            // check if the user is logged in or not
                            message = vm.isUserLoggedIn
                                ? 'Successfully logged in!'
                                : vm.errorMessage;

                            // show the snack bar
                            ScaffoldMessenger.of(
                              // ignore: use_build_context_synchronously
                              context,
                            ).showSnackBar(SnackBar(content: Text(message)));

                            void redirectHomeScreen() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const HomePage(),
                                ),
                              );
                            }

                            //after successfully registered as well as logged in we'll redirect them
                            //to the home screen
                            if (vm.isUserCreated && vm.isLoading) {
                              redirectHomeScreen();
                            }
                          },
                          child: const Text('Sign Up'),
                        ),

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
