import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:my_notes/constants/dimes.dart';
import 'package:my_notes/constants/sizeExtentions.dart';
import 'package:my_notes/constants/strings.dart';
import 'package:my_notes/constants/utils.dart';
import 'package:my_notes/screen/create_pin/create_pin_viewmodel.dart';
import 'package:my_notes/screen/create_pin/widget/pin_input_number_widget.dart';
import 'package:my_notes/screen/create_pin/widget/pin_textfield_row.dart';
import 'package:my_notes/widgets/app_textformfield_new.dart';
import 'package:my_notes/widgets/default_appbar_leading.dart';
import 'package:my_notes/widgets/default_appbar_title.dart';
import 'package:stacked/stacked.dart';

class CreatePinView extends StatefulWidget {
  const CreatePinView({super.key});

  @override
  State<CreatePinView> createState() => _CreatePinViewState();
}

class _CreatePinViewState extends State<CreatePinView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => CreatePinViewModel(),
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
                    verticalSpace(80),
                    Text(
                      'Create a new PIN',
                      style: context.displaySmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Please enter your passcode',
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
                    verticalSpace(70),
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
                                value: '1',
                                context: context,
                              );
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
