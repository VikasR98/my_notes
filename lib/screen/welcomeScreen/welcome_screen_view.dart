import 'package:flutter/material.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:my_notes/constants/routes.dart';
import 'package:my_notes/constants/strings.dart';
import 'package:my_notes/screen/signUp/sign_up_view.dart';
import 'package:my_notes/screen/welcomeScreen/welcome_screen_viewmodel.dart';
import 'package:my_notes/widgets/app_button.dart';
import 'package:my_notes/widgets/app_logo_asset.dart';
import 'package:stacked/stacked.dart';

class WelcomeScreenView extends StatefulWidget {
  const WelcomeScreenView({Key? key}) : super(key: key);

  @override
  State<WelcomeScreenView> createState() => _WelcomeScreenViewState();
}

class _WelcomeScreenViewState extends State<WelcomeScreenView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => WelcomeScreenViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          // backgroundColor: AppColors.lightModeBgColor,

          body: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const AppLogoAsset(),
              Expanded(
                child: SizedBox(
                  // color: Colors.amber,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            welcomeText,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  // fontSize: 48,
                                ),
                          ),
                          Text(
                            welcomeSubtextPartOne,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          Text(
                            welcomeSubTextPartTwo,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),

                      // Spacer(),
                      Column(
                        children: [
                          AppButton(
                            btnText: 'Create Account',
                            onTap: () {
                              Navigator.pushNamed(context, signUpRoute);
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          AppButton(
                            btnText: 'Sign In',
                            onTap: () {
                              Navigator.pushNamed(context, signInRoute);
                              // Navigator.push
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            welcomeBottomText,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
