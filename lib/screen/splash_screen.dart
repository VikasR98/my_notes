import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  bool _isLoading = true;
  bool _hasError = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _initApp();
  }

  _initApp() async {
    // await FirebaseAuth.instance
    //     .signOut(); // 👈 force logout on app start (for testing)
    setState(() {
      _hasError = false;
      _isLoading = true;
    });

    try {
      await DatabaseHelper().database;
      setState(() {
        _isLoading = false;
      });
      if (!mounted) return; // prenvents navigation after dispose
      goToNextRoute();
    } catch (e) {
      log(e.toString());
      Fluttertoast.showToast(msg: "Error creating database");
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  void goToNextRoute() async {
    final sharedPrefs = locator<SharedPreferencesService>();

    // insertDemoUserIfNotExists();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
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

  Widget _buildErrorUI() {
    return Center(
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 16),
          const Text("Failed to initialize app"),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _initApp,
            child: Text(
              "Retry",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _hasError
          ? _buildErrorUI()
          : Column(
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
