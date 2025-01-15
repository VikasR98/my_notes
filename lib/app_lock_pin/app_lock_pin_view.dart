import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_notes/app_lock_pin/app_lock_pin_viewmodel.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:my_notes/constants/dimes.dart';
import 'package:my_notes/constants/sizeExtentions.dart';
import 'package:my_notes/constants/strings.dart';
import 'package:my_notes/constants/utils.dart';
import 'package:my_notes/screen/create_pin/widget/pin_input_number_widget.dart';
import 'package:my_notes/screen/create_pin/widget/pin_textfield_row.dart';
import 'package:stacked/stacked.dart';

class AppLockPinView extends StatefulWidget {
  const AppLockPinView({super.key});

  @override
  State<AppLockPinView> createState() => _AppLockPinViewState();
}

class _AppLockPinViewState extends State<AppLockPinView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        onViewModelReady: (viewModel) {
          viewModel.setProfileImage();
        },
        viewModelBuilder: () => AppLockPinViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
              // appBar: AppBar(),
              // appBar: AppBar(
              //   leading: const AppBarBackArrow(),
              //   title: const DefaultAppBarTitle(title: createPinString),
              // ),
              body: Center(
            child: Column(
              // mainAxisSize: MainAxisSize.max,

              children: [
                verticalSpace(100),
                UserProfileImageWidget(
                  profileImage: viewModel.profileImage,
                ),
                verticalSpace(20),
                Text(
                  'Welcome, ${viewModel.userName}',
                  style: context.displaySmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                if (viewModel.isShowIncorrectPinMsg == false) ...[
                  Text(
                    lockUiFirstMsg,
                    style: context.bodyMedium?.copyWith(),
                  ),
                ],
                if (viewModel.isShowIncorrectPinMsg == true) ...[
                  Text(
                    incorrectPinMsg,
                    style: context.bodyMedium?.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],

                verticalSpace(20),
                PinTextFieldsRow(
                  showPin: viewModel.showPin,
                  isFirstFilled: viewModel.firstFilled,
                  firstValue: viewModel.firstChar ?? '',
                  isSecondFilled: viewModel.secondFilled,
                  secondValue: viewModel.secondChar ?? '',
                  isThirdFilled: viewModel.thirdFilled,
                  thirdValue: viewModel.thirdChar ?? '',
                  isFourthFilled: viewModel.fourthFilled,
                  fourthValue: viewModel.fourthChar ?? '',
                ),
                verticalSpace(20),
                GestureDetector(
                  onTap: () {
                    viewModel.showPin = !viewModel.showPin;
                  },
                  child: Icon(
                    Icons.remove_red_eye,
                    size: 30,
                    color: viewModel.showPin
                        ? AppColors.primaryColor
                        : Colors.grey,
                  ),
                ),
                // verticalSpace(90),
                Flexible(
                  child: GridView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      // mainAxisExtent: 100,
                      // crossAxisSpacing: 0,
                      // mainAxisExtent: 3,
                      mainAxisSpacing: 25,
                      childAspectRatio: 2 / 1,
                    ),
                    children: [
                      PinInputNumberWidget(
                        label: '1',
                        onTap: () {
                          viewModel.enterValue(
                            value: '1',
                            context: context,
                          );
                        },
                      ),
                      PinInputNumberWidget(
                        label: '2',
                        onTap: () {
                          viewModel.enterValue(value: '2', context: context);
                        },
                      ),
                      PinInputNumberWidget(
                        label: '3',
                        onTap: () {
                          viewModel.enterValue(value: '3', context: context);
                        },
                      ),
                      PinInputNumberWidget(
                        label: '4',
                        onTap: () {
                          viewModel.enterValue(value: '4', context: context);
                        },
                      ),
                      PinInputNumberWidget(
                        label: '5',
                        onTap: () {
                          viewModel.enterValue(value: '5', context: context);
                        },
                      ),
                      PinInputNumberWidget(
                        label: '6',
                        onTap: () {
                          viewModel.enterValue(value: '6', context: context);
                        },
                      ),
                      PinInputNumberWidget(
                        label: '7',
                        onTap: () {
                          viewModel.enterValue(value: '7', context: context);
                        },
                      ),
                      PinInputNumberWidget(
                        label: '8',
                        onTap: () {
                          viewModel.enterValue(value: '8', context: context);
                        },
                      ),
                      PinInputNumberWidget(
                        label: '9',
                        onTap: () {
                          viewModel.enterValue(value: '9', context: context);
                        },
                      ),
                      PinInputNumberWidget(
                        onTap: () {
                          viewModel.showEnteredPin();
                        },
                        icon: const Icon(
                          Icons.fingerprint,
                          size: Dimens.iconSize50,
                        ),
                      ),
                      PinInputNumberWidget(
                        label: '0',
                        onTap: () {
                          viewModel.enterValue(value: '0', context: context);
                        },
                      ),
                      PinInputNumberWidget(
                        onTap: () {
                          // viewModel.checkStatus();
                          viewModel.backButton();
                        },
                        icon: const Icon(
                          Icons.backspace,
                          size: Dimens.iconSize50,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ));
        });
  }
}

class UserProfileImageWidget extends StatelessWidget {
  const UserProfileImageWidget({
    super.key,
    required this.profileImage,
  });

  final File? profileImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        border: Border.all(
          color: Colors.transparent,
          width: 1,
        ),
        gradient: const LinearGradient(
          colors: [
            Color(0xffFFE0B2),
            Color(0xffFDD29A),
          ],
        ),
      ),
      child: profileImage != null
          ? CircleAvatar(
              backgroundColor: Colors.transparent,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(50),
                ),
                child: Image.file(
                  profileImage!,
                  width: 70,
                  scale: 1,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
            )
          : const Icon(
              Icons.person,
              size: 35,
            ),
    );
  }
}
