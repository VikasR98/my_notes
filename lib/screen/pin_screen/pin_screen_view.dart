import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:my_notes/constants/dimes.dart';
import 'package:my_notes/constants/sizeExtentions.dart';
import 'package:my_notes/constants/strings.dart';
import 'package:my_notes/constants/utils.dart';
import 'package:my_notes/screen/pin_screen/pin_screen_viewmodel.dart';
import 'package:my_notes/screen/pin_screen/widget/pin_textfield_row.dart';
import 'package:my_notes/widgets/app_textformfield_new.dart';
import 'package:my_notes/widgets/default_appbar_leading.dart';
import 'package:my_notes/widgets/default_appbar_title.dart';
import 'package:stacked/stacked.dart';

class PinScreenView extends StatefulWidget {
  const PinScreenView({super.key});

  @override
  State<PinScreenView> createState() => _PinScreenViewState();
}

class _PinScreenViewState extends State<PinScreenView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => PinScreenViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
              appBar: AppBar(
                leading: const DefaultAppBarLeading(),
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
                    PinTextFieldsRow(viewModel: viewModel,),
                    verticalSpace(100),
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
                              viewModel.enterValue(value: '1');
                            },
                          ),
                          PinInputNumberWidget(
                            label: '2',
                            onTap: () {
                              viewModel.enterValue(value: '2');
                            },
                          ),
                          PinInputNumberWidget(
                            label: '3',
                            onTap: () {
                              viewModel.enterValue(value: '3');
                            },
                          ),
                          PinInputNumberWidget(
                            label: '4',
                            onTap: () {
                              viewModel.enterValue(value: '4');
                            },
                          ),
                          PinInputNumberWidget(
                            label: '5',
                            onTap: () {
                              viewModel.enterValue(value: '5');
                            },
                          ),
                          PinInputNumberWidget(
                            label: '6',
                            onTap: () {
                              viewModel.enterValue(value: '6');
                            },
                          ),
                          PinInputNumberWidget(
                            label: '7',
                            onTap: () {
                              viewModel.enterValue(value: '7');
                            },
                          ),
                          PinInputNumberWidget(
                            label: '8',
                            onTap: () {
                              viewModel.enterValue(value: '8');
                            },
                          ),
                          PinInputNumberWidget(
                            label: '9',
                            onTap: () {
                              viewModel.enterValue(value: '9');
                            },
                          ),
                          PinInputNumberWidget(
                            onTap: () {
                              viewModel.showPin();
                            },
                            icon: const Icon(
                              Icons.fingerprint,
                              size: Dimens.iconSize50,
                            ),
                          ),
                          PinInputNumberWidget(
                            label: '0',
                            onTap: () {
                              viewModel.enterValue(value: '0');
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
    return Container(
      // color: Colors.amber,
      child: GestureDetector(
        onTap: onTap,
        child: icon ??
            Center(
              child: GestureDetector(
                onTap: onTap,
                child: Text(
                  label ?? '',
                  style: context.displayMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
