import 'package:flutter/material.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:my_notes/constants/dimes.dart';
import 'package:my_notes/constants/routes.dart';
import 'package:my_notes/constants/utils.dart';
import 'package:my_notes/screen/signIn/sign_in_viewmodel.dart';
import 'package:my_notes/widgets/app_button.dart';
import 'package:my_notes/widgets/app_logo_asset.dart';
import 'package:my_notes/widgets/app_textformfield_new.dart';
import 'package:stacked/stacked.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => SignInViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: SizedBox(
                // color: Colors.amber,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const AppLogoAsset(),
                        Text(
                          'Sign In',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                      ],
                    ),
                    Form(
                        autovalidateMode: viewModel.formAutoValidate,
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Column(
                            children: [
                              AppTextFormFieldNew(
                                label: 'Email Address',
                                textEditingController:
                                    viewModel.emailController,
                                onChanged: (String value) {
                                  viewModel.isAllValueFilled();
                                },
                                validator: (String? value) {
                                  if (value == null ||
                                      !viewModel.isMailValid()) {
                                    return 'Invalid email id';
                                  }
                                  return null;
                                },
                              ),
                              verticalSpace(20),
                              AppTextFormFieldNew(
                                label: 'Password',
                                obscureText: obscure,
                                onChanged: (String value) {
                                  viewModel.isAllValueFilled();
                                },
                                validator: (String? value) {
                                  if (value == null || value.length <= 6) {
                                    return 'Password must be more than 6';
                                  }
                                  return null;
                                },
                                textEditingController:
                                    viewModel.passwordController,
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      obscure = !obscure;
                                    });
                                  },
                                  child: Icon(
                                    Icons.remove_red_eye,
                                    color: obscure == true
                                        ? Colors.grey
                                        : AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),

                    // Spacer(),
                    AppButton(
                      bgColor: viewModel.allValComplete
                          ? AppColors.primaryColor
                          : AppColors.accentColorFifty,
                      onTap: () {
                        // if (_formKey.currentState!.validate()) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          entryListRoute,
                          (route) => false,
                        );
                        // } else {
                        //   viewModel.formAutoValidate = AutovalidateMode.always;
                        // }
                      },
                      btnText: 'Sign In',
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
