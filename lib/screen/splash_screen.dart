import 'package:flutter/material.dart';
import 'package:my_notes/constants/routes.dart';
import 'package:my_notes/databse_helper/data_base_helper.dart';
import 'package:my_notes/service/locator.dart';
import 'package:my_notes/service/shared_prefs_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    goToNextRoute();
  }

  Future<void> insertDemoUserIfNotExists() async {
    const demoEmail = 'demo@example.com';
    const demoPassword = 'demo1234';
    const demoName = 'Demo User';

    await DatabaseHelper().registerUser(
      name: demoName,
      email: demoEmail,
      password: demoPassword,
    );
  }

  void goToNextRoute() {
    final sharedPrefs = locator<SharedPreferencesService>();
    insertDemoUserIfNotExists();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (sharedPrefs.getUserId() != null) {
          if (sharedPrefs.getIsPinEnabled() != null &&
              sharedPrefs.getIsPinEnabled() == true) {
            Navigator.pushReplacementNamed(context, appLockPinRoute);
          } else {
            Navigator.pushReplacementNamed(context, entryListRoute);
          }
        } else {
          Navigator.pushReplacementNamed(context, onboardingRoute);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.fitHeight,
            ),
          ),
        ],
      ),
    );
  }
}
