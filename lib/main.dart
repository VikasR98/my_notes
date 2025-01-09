import 'package:flutter/material.dart';

import 'package:my_notes/app/app_theme.dart';
import 'package:my_notes/app/dark_theme.dart';
import 'package:my_notes/constants/routes.dart';
import 'package:my_notes/onboarding/onboarding_view.dart';
import 'package:my_notes/screen/addEntry/add_entry_view.dart';
import 'package:my_notes/screen/entryList/entry_list_view.dart';
import 'package:my_notes/screen/pin_screen/pin_screen_view.dart';
import 'package:my_notes/screen/settings/settings_view.dart';
import 'package:my_notes/screen/signIn/sign_in_view.dart';
import 'package:my_notes/screen/signUp/sign_up_view.dart';
import 'package:my_notes/screen/splash_screen.dart';
import 'package:my_notes/screen/viewEntry/view_entry_view.dart';
import 'package:my_notes/screen/welcomeScreen/welcome_screen_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Add a new entry

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      initialRoute: '/',

      routes: {
        '/': (context) => const SplashScreen(),
        welcomeRoute: (context) => const WelcomeScreenView(),
        signUpRoute: (context) => const SignUpView(),
        signInRoute: (context) => const SignInView(),
       entryListRoute : (context) => const EntryListView(),
        settingsRoute: (context) => const SettingsView(),
        pinScreenRoute: (_) => const PinScreenView(),
        addEntryRoute: (_) => const AddEntryView(),
        viewEntryRoute:(_)=> const ViewEntryView(),
        onboardingRoute:(_)=>const OnboardingView(),

      },
      // home: const FigmaToLottie(),
    );
  }
}
