import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'package:my_notes/app/app_theme.dart';
import 'package:my_notes/app/dark_theme.dart';
import 'package:my_notes/app_lock_pin/app_lock_pin_view.dart';
import 'package:my_notes/constants/routes.dart';
import 'package:my_notes/onboarding/onboarding_view.dart';
import 'package:my_notes/screen/addEntry/add_entry_view.dart';
import 'package:my_notes/screen/confirm_pin/confirm_pin_view.dart';
import 'package:my_notes/screen/confirm_pin/widgets/pin_create_success_view.dart';
import 'package:my_notes/screen/create_pin/create_pin_view.dart';
import 'package:my_notes/screen/entryList/entry_list_view.dart';
import 'package:my_notes/screen/settings/settings_view.dart';
import 'package:my_notes/screen/signIn/sign_in_view.dart';
import 'package:my_notes/screen/signUp/sign_up_view.dart';
import 'package:my_notes/screen/splash_screen.dart';
import 'package:my_notes/screen/viewEntry/view_entry_view.dart';
import 'package:my_notes/screen/welcomeScreen/welcome_screen_view.dart';
import 'package:my_notes/service/locator.dart';
import 'package:my_notes/service/shared_prefs_service.dart';
import 'package:my_notes/theme_demo/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize and register services
  await setupLocator();
  runApp(
      // DevicePreview(
      //   enabled: kDebugMode,
      //   builder: (context) => const MyApp(),
      // ),
      const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _isDarkTheme;

  @override
  void initState() {
    super.initState();
    _isDarkTheme = locator<SharedPreferencesService>().getDarkTheme() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Builder(builder: (context) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          initialRoute: '/',
          themeMode:
              themeProvider.isDarkTheme ? ThemeMode.dark : ThemeMode.light,

          routes: {
            '/': (context) => const SplashScreen(),
            welcomeRoute: (context) => const WelcomeScreenView(),
            signUpRoute: (context) => const SignUpView(),
            signInRoute: (context) => const SignInView(),
            entryListRoute: (context) => const EntryListView(),
            settingsRoute: (context) => const SettingsView(),
            pinScreenRoute: (_) => const CreatePinView(),
            addEntryRoute: (_) => const AddEntryView(),
            viewEntryRoute: (_) => const ViewEntryView(),
            onboardingRoute: (_) => const OnboardingView(),
            confirmPinRoute: (_) => const ConfirmPinView(),
            pinCreateSuccessRoute: (_) => const PinCreateSuccessView(),
            appLockPinRoute: (_) => const AppLockPinView(),
          },
          // home: const FigmaToLottie(),
        );
      }),
    );
  }
}
