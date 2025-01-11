import 'package:flutter/material.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:my_notes/constants/dimes.dart';
import 'package:my_notes/constants/routes.dart';
import 'package:my_notes/constants/sizeExtentions.dart';
import 'package:my_notes/constants/strings.dart';
import 'package:my_notes/screen/settings/settings_viewModel.dart';
import 'package:my_notes/screen/settings/widget/app_switch_widget.dart';
import 'package:my_notes/screen/settings/widget/settings_row_widget.dart';
import 'package:my_notes/widgets/app_image_picker.dart';
import 'package:my_notes/widgets/default_appbar_leading.dart';
import 'package:my_notes/widgets/default_appbar_title.dart';
import 'package:stacked/stacked.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    Brightness theme = Theme.of(context).brightness;
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel)async{
        viewModel.setProfileImage();
      },
        viewModelBuilder: () => SettingsViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
                leading: const AppBarBackArrow(),
                title: const DefaultAppBarTitle(title: 'Settings')),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        height: context.height * 0.75,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 30,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 50,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: Column(
                          children: [
                            SettingsRow(
                              onTap: () {
                                viewModel.pickImage();
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (_) => ImagePickerExample()));
                              },
                              label: changeProfileImageString,
                              icon: CircleAvatar(
                                backgroundColor: AppColors.iconBgColor,
                                radius: 25,
                                child: viewModel.profileImage != null
                                    ? ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(50),
                                        ),
                                        child: Image.file(
                                          viewModel.profileImage!,
                                          width: 35,
                                          height: 35,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : const Icon(
                                        Icons.person,
                                        size: 35,
                                      ),
                              ),
                            ),
                            SettingsRow(
                              label: darkModeString,
                              icon: AppSwitchWidget(
                                value: viewModel.darkModeSwitchVal,
                                onChanged: (bool? val) {
                                  viewModel.darkModeSwitchVal = val ?? true;
                                },
                              ),
                            ),
                            SettingsRow(
                              label: bioMetricString,
                              icon: AppSwitchWidget(
                                value: viewModel.bioMatricSwitchVal,
                                onChanged: (bool? val) {
                                  viewModel.bioMatricSwitchVal = val ?? true;
                                },
                              ),
                            ),
                            SettingsRow(
                              label: syncAutoString,
                              icon: AppSwitchWidget(
                                value: viewModel.syncAutoSwitchVal,
                                onChanged: (bool? val) {
                                  viewModel.syncAutoSwitchVal = val ?? true;
                                },
                              ),
                            ),
                            SettingsRow(
                              onTap: () {
                                viewModel.syncNow();
                              },
                              label: syncNowString,
                              icon: viewModel.getSyncWidget(),
                            ),
                            SettingsRow(
                              onTap: () {
                                // viewModel.syncNow();
                                Navigator.pushNamed(context, '/pinScreenRoute');
                              },
                              label: 'Pin Screen',
                              icon: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              viewModel.logout(context);
                            },
                            child: Container(
                              color: Colors.amber,
                              child: Text(
                                logoutString,
                                style: context.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if(viewModel.isBusy)
                  const Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: AppColors.primaryColor,
                      strokeWidth: 10,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      // value: 1,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
