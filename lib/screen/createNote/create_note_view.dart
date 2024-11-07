import 'package:flutter/material.dart';
import 'package:my_notes/app/image_config.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:my_notes/constants/dimes.dart';
import 'package:my_notes/constants/strings.dart';
import 'package:my_notes/constants/utils.dart';
import 'package:my_notes/screen/createNote/localWidgets/create_note_body.dart';
import 'package:my_notes/screen/createNote/create_note_viewmodel.dart';
import 'package:my_notes/screen/createNote/localWidgets/editing_icon_widget.dart';
import 'package:my_notes/screen/createNote/localWidgets/entry_header.dart';
import 'package:my_notes/widgets/default_appbar_leading.dart';
import 'package:my_notes/widgets/default_appbar_title.dart';
import 'package:my_notes/widgets/description_textfield.dart';
import 'package:stacked/stacked.dart';

class CreateNoteView extends StatefulWidget {
  const CreateNoteView({Key? key}) : super(key: key);

  @override
  State<CreateNoteView> createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends State<CreateNoteView> {
  FontWeight fontWeight = FontWeight.normal;
  FontStyle fontStyle = FontStyle.normal;
  // TextAlign textAlign = TextAlign.left;

  @override
  Widget build(BuildContext context) {
    Brightness theme = Theme.of(context).brightness;
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => CreateNoteViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
              appBar: AppBar(
                leading: const DefaultAppBarLeading(),
                title: const DefaultAppBarTitle(title: addEntryString),
              ),
              body: Column(
                children: [
                  verticalSpace(10),
                  EntryHeader(
                    theme: theme,
                    lastEditTime: viewModel.lastEditTime,
                    onChanged: (String value) {
                      // print('on desc: ${textAlign}');
                      viewModel.getLastEditTime(DateTime.now());
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        EditIcon(
                          iconData: Icons.format_align_left_rounded,
                          onTap: () {
                            // setState(() {
                            viewModel.textAlign = TextAlign.left;
                            // print('left');
                            // });
                          },
                        ),
                        EditIcon(
                          iconData: Icons.format_align_center_rounded,
                          onTap: () {
                            // setState(() {
                            viewModel.textAlign = TextAlign.center;
                            // print('centre');
                            // });
                          },
                        ),
                        EditIcon(
                          iconData: Icons.format_align_right_rounded,
                          onTap: () {
                            // setState(() {
                            viewModel.textAlign = TextAlign.right;
                            // print('right');
                            // });

                            print('align');
                          },
                        ),
                        EditIcon(
                          iconData: Icons.format_bold_rounded,
                          onTap: () {
                            setState(() {
                              if (fontWeight == FontWeight.w900) {
                                fontWeight = FontWeight.normal;
                              } else {
                                fontWeight = FontWeight.w900;
                              }
                            });
                          },
                        ),
                        EditIcon(
                          iconData: Icons.format_italic_rounded,
                          onTap: () {
                            setState(() {
                              if (fontStyle != FontStyle.italic) {
                                fontStyle = FontStyle.italic;
                              } else {
                                fontStyle = FontStyle.normal;
                              }
                            });
                          },
                        ),
                        EditIcon(
                          iconData: Icons.format_underline_rounded,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        // color: Colors.amber,
                        color: theme == Brightness.light
                            ? AppColors.appWhite
                            : AppColors.darkModeSecondaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Dimens.entryDescriptionBorderRadius(),
                          topRight: Dimens.entryDescriptionBorderRadius(),
                        ),
                      ),
                      child: DescriptionTextField(
                        fontWeight: fontWeight,
                        fontStyle: fontStyle,
                        textAlign: viewModel.textAlign,
                        onChanged: (String value) {
                          // print('on desc: ${textAlign}');
                          viewModel.getLastEditTime(DateTime.now());
                        },
                      ),
                    ),
                  ),
                  Container(
                    // height: 80,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Mood',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Row(
                          children: [
                            MoodEmojiWidget(
                              value: 1,
                              selectedValue: viewModel.selectedValue,
                              selectedMood: viewModel.selectedMood,
                              onTap: () {
                                viewModel.selectedValue = 1;
                                // viewModel.selectedMood = 'happinessEmoji';
                              },
                              iconName: happinessEmoji,
                            ),
                            MoodEmojiWidget(
                              value: 2,
                              selectedValue: viewModel.selectedValue,
                              selectedMood: viewModel.selectedMood,
                              onTap: () {
                                // setState(() {
                                  viewModel.selectedValue = 2;
                                  // viewModel.selectedMood = 'neutralEmoji';
                                // });
                                // print('netral');
                              },
                              iconName: neutralEmoji,
                            ),
                            MoodEmojiWidget(
                              value: 3,
                              selectedValue: viewModel.selectedValue,
                              selectedMood: viewModel.selectedMood,
                              onTap: () {
                                viewModel.selectedValue = 3;
                                // viewModel.selectedMood = 'confusedEmoji';
                              },
                              iconName: confusedEmoji,
                            ),
                            MoodEmojiWidget(
                              value: 4,
                              selectedValue: viewModel.selectedValue,
                              selectedMood: viewModel.selectedMood,
                              onTap: () {
                                viewModel.selectedValue = 4;
                                // viewModel.selectedMood = 'signEmoji';
                                // print('sign');
                              },
                              iconName: signEmoji,
                            ),
                            MoodEmojiWidget(
                              value: 5,
                              selectedValue: viewModel.selectedValue,
                              selectedMood: viewModel.selectedMood,
                              onTap: () {

                                // setState(() {
                                  viewModel.selectedValue = 5;
                                //   viewModel.selectedMood = 'sadEmoji';
                                // });
                              },
                              iconName: sadEmoji,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )
              // CreateNoteBody(
              //   viewModel:viewModel,
              //   textAlign: viewModel.textAlign,
              //   selectedMood:viewModel.selectedMood,
              //   lastEditTime: viewModel.lastEditTime,
              //   onChanged: (String value) {
              //     print('on desc: ${viewModel.textAlign}');
              //     viewModel.getLastEditTime(DateTime.now());
              //   },
              // ),
              );
        });
  }
}


