import 'package:flutter/material.dart';
import 'package:my_notes/app/image_config.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:my_notes/constants/routes.dart';
import 'package:my_notes/constants/strings.dart';
import 'package:my_notes/constants/utils.dart';
import 'package:my_notes/widgets/app_button.dart';

class PinCreateSuccessView extends StatefulWidget {
  const PinCreateSuccessView({super.key});

  @override
  State<PinCreateSuccessView> createState() => _PinCreateSuccessViewState();
}

class _PinCreateSuccessViewState extends State<PinCreateSuccessView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          // color: Colors.amber,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              verticalSpace(30),
              Image.asset(
                checked,
                // color: AppColors.primaryColor,

                height: 150,
                // fit: BoxFit.contain,
              ),
              Column(
                children: [
                  Text(
                    setPinSuccessOne,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    setPinSuccessTwo,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Text(
                  //   successMessageThree,
                  //   style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                ],
              ),
              verticalSpace(10),


            AppButton(
                onTap: () {
                  int count = 0;
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    settingsRoute, // The route to navigate to
                        (route) {
                      // Custom predicate to remove only the last 2 routes
                     // Track the number of removed routes
                      if (count < 4) {
                        count++;
                        return false; // Remove this route
                      }
                      return true; // Stop removing routes
                    },
                  );
                },
                btnText: 'Go back to settings',
              )
            ],
          ),
        ),
      ),
    );
  }
}
