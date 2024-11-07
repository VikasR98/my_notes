import 'package:flutter/material.dart';
import 'package:my_notes/app/image_config.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:my_notes/constants/dimes.dart';
import 'package:my_notes/constants/strings.dart';
import 'package:my_notes/constants/utils.dart';
import 'package:my_notes/screen/signUp/localWidget/user_registered_success_view.dart';
import 'package:my_notes/screen/signUp/sign_up_viewmodel.dart';
import 'package:my_notes/widgets/app_button.dart';
import 'package:my_notes/widgets/app_logo_asset.dart';
import 'package:my_notes/widgets/app_textformfield_new.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool obscure = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => SignUpViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: viewModel.userRegistered == true
                  ? const UserRegisteredSuccessView()
                  : SizedBox(
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
                                'Sign Up',
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
                              autovalidateMode: viewModel.validateMode,
                              key: _formKey,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                                child: Column(
                                  children: [
                                    AppTextFormFieldNew(
                                      inputFormatters: [
                                        Dimens().alphabeticFormatter
                                      ],
                                      label: 'Name',
                                      textEditingController:
                                          viewModel.nameController,
                                      onChanged: (String value) {
                                        viewModel.isAllValueFilled();
                                      },
                                      validator: (String? value) {
                                        if (value == null ||
                                            value.length <= 3) {
                                          return 'Characters must be more than 3';
                                        }
                                        return null;
                                      },
                                    ),
                                    verticalSpace(20),
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
                                        if (value == null ||
                                            value.length <= 6) {
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
                              if (_formKey.currentState!.validate()) {
                                viewModel.userRegistered = true;
                              } else {
                                viewModel.validateMode =
                                    AutovalidateMode.always;
                              }
                            },
                            btnText: 'Sign Up',
                          )
                        ],
                      ),
                    ),
            ),
          );
        });
  }
}
