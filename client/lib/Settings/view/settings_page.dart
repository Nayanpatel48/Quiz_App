import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repradar/Auth/view/login_page.dart';
import 'package:repradar/Auth/view/widgets/loading_indicator.dart';
import 'package:repradar/Settings/viewmodel/settings_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings Page')),

      //---------
      body: ChangeNotifierProvider(
        create: (context) {
          final vm = SettingsViewModel();

          //call the data fetch immediately after the view model is initiated.
          vm.getCurrentlyLoggedInUser();
          return vm;
        },
        child: Consumer<SettingsViewModel>(
          builder: (context, vm, _) {
            return Padding(
              padding: const EdgeInsets.all(8),

              //-------
              child: Column(
                children: [
                  Text(
                    'Username : ${vm.currentlyLoggedInUserData?.username}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Email : ${vm.currentlyLoggedInUserData?.email}',
                    style: TextStyle(fontSize: 20),
                  ),

                  //----------------------
                  vm.isLoading
                      ? LoadingIndicator()
                      : ElevatedButton(
                          onPressed: () async {
                            // It removes the user's saved 'token' from the device's local storage.
                            //This token is what typically keeps the user logged in between app sessions.
                            final pref = await SharedPreferences.getInstance();

                            await pref.remove('token');

                            Navigator.push(
                              // ignore: use_build_context_synchronously
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Logout',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                ],

                //--------
              ),
            );
          },
        ),
      ),
    );
  }
}
