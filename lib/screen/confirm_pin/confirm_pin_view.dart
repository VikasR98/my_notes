import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:my_notes/constants/dimes.dart';
import 'package:my_notes/constants/sizeExtentions.dart';
import 'package:my_notes/constants/strings.dart';
import 'package:my_notes/constants/utils.dart';
import 'package:my_notes/screen/confirm_pin/confirm_pin_viewmodel.dart';
import 'package:my_notes/screen/create_pin/widget/pin_textfield_row.dart';
import 'package:my_notes/widgets/app_textformfield_new.dart';
import 'package:my_notes/widgets/default_appbar_leading.dart';
import 'package:my_notes/widgets/default_appbar_title.dart';
import 'package:stacked/stacked.dart';

class ConfirmPinView extends StatefulWidget {
  const ConfirmPinView({
    super.key,
  });

  @override
  State<ConfirmPinView> createState() => _ConfirmPinViewState();
}

class _ConfirmPinViewState extends State<ConfirmPinView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        onViewModelReady: (viewModel) {
          try {
            final args = ModalRoute.of(context)?.settings.arguments
                as ConfirmPinViewArgs;
            log(args.pin);
            viewModel.pinValueOne = args.pin;
          } catch (e) {
            if (kDebugMode) {
              print('confirm_pin_view - $e');
            }
          }
        },
        viewModelBuilder: () => ConfirmPinViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
              appBar: AppBar(
                leading: const AppBarBackArrow(),
                title: const DefaultAppBarTitle(title: createPinString),
              ),
              body: Center(
                child: Column(
                  // mainAxisSize: MainAxisSize.max,
                  children: [
                    verticalSpace(40),
                    Text(
                      reEntryPinTitle,
                      textAlign: TextAlign.center,
                      style: context.displaySmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      reEnterPinSubtitle,
                      style: context.bodyMedium?.copyWith(),
                    ),
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
                    verticalSpace(10),
                    if (viewModel.isWrongPin == true) ...[
                      Text(
                        'Pin does not match',
                        style: context.labelSmall?.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      )
                    ],
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
                    verticalSpace(40),
                    Flexible(
                      child: GridView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          // mainAxisExtent: 100,
                          // crossAxisSpacing: 50,
                          // mainAxisExtent: 3,
                          mainAxisSpacing: 30,
                          childAspectRatio: 2 / 1,
                        ),
                        children: [
                          PinInputNumberWidget(
                            label: '1',
                            onTap: () {
                              viewModel.enterValue(
                                  value: '1', context: context);
                            },
                          ),
                          PinInputNumberWidget(
                            label: '2',
                            onTap: () {
                              viewModel.enterValue(
                                  value: '2', context: context);
                            },
                          ),
                          PinInputNumberWidget(
                            label: '3',
                            onTap: () {
                              viewModel.enterValue(
                                  value: '3', context: context);
                            },
                          ),
                          PinInputNumberWidget(
                            label: '4',
                            onTap: () {
                              viewModel.enterValue(
                                  value: '4', context: context);
                            },
                          ),
                          PinInputNumberWidget(
                            label: '5',
                            onTap: () {
                              viewModel.enterValue(
                                  value: '5', context: context);
                            },
                          ),
                          PinInputNumberWidget(
                            label: '6',
                            onTap: () {
                              viewModel.enterValue(
                                  value: '6', context: context);
                            },
                          ),
                          PinInputNumberWidget(
                            label: '7',
                            onTap: () {
                              viewModel.enterValue(
                                  value: '7', context: context);
                            },
                          ),
                          PinInputNumberWidget(
                            label: '8',
                            onTap: () {
                              viewModel.enterValue(
                                  value: '8', context: context);
                            },
                          ),
                          PinInputNumberWidget(
                            label: '9',
                            onTap: () {
                              viewModel.enterValue(
                                  value: '9', context: context);
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
                              viewModel.enterValue(
                                  value: '0', context: context);
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

class PinInputNumberWidget extends StatelessWidget {
  String? label;
  final void Function()? onTap;
  Widget? icon;

  PinInputNumberWidget({
    super.key,
    this.label,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(1),
        height: 40,
        width: 40,
        // color: Colors.red,
        child: icon ??
            Center(
              child: Text(
                label ?? '',
                style: context.displayMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
      ),
    );
  }
}

class ConfirmPinViewArgs {
  final String pin;

  ConfirmPinViewArgs({required this.pin});
}
