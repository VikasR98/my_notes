import 'package:flutter/material.dart';
import 'package:my_notes/app/image_config.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:my_notes/constants/strings.dart';
import 'package:my_notes/constants/utils.dart';
import 'package:my_notes/widgets/app_button.dart';

class UserRegisteredSuccessView extends StatelessWidget {
  const UserRegisteredSuccessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
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
                  successMessageOne,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  successMessageTwo,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  successMessageThree,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            verticalSpace(10),

            AppButton(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/signInRoute');
              },
              btnText: 'Sign In',
            )
          ],
        ),
      ),
    );
  }
}


