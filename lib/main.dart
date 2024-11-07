import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:my_notes/app/app_theme.dart';
import 'package:my_notes/app/dark_theme.dart';
import 'package:my_notes/screen/notesList/notes_list_view.dart';
import 'package:my_notes/screen/pin_screen/pin_screen_view.dart';
import 'package:my_notes/screen/settings/settings_view.dart';
import 'package:my_notes/screen/signIn/sign_in_view.dart';
import 'package:my_notes/screen/signUp/sign_up_view.dart';
import 'package:my_notes/screen/splash_screen.dart';
import 'package:my_notes/screen/welcomeScreen/welcome_screen_view.dart';

import 'constants/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        '/welcomeRoute': (context) => const WelcomeScreenView(),
        '/signUpRoute': (context) => const SignUpView(),
        '/signInRoute': (context) => const SignInView(),
        '/notesListRoute': (context) => const NotesListView(),
        '/settingsRoute':(context)=>const SettingsView(),
        '/pinScreenRoute':(_)=>const PinScreenView(),
      },
      // home: const SplashScreen(),
    );
  }
}
