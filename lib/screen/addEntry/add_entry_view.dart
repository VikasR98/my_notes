import 'package:flutter/material.dart';
import 'package:my_notes/app/image_config.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:my_notes/constants/dimes.dart';
import 'package:my_notes/constants/strings.dart';
import 'package:my_notes/constants/utils.dart';
import 'package:my_notes/enum/form_action.dart';
import 'package:my_notes/model/data_entry.dart';
import 'package:my_notes/screen/addEntry/add_entry_viewmodel.dart';
import 'package:my_notes/screen/addEntry/localWidgets/create_note_body.dart';
import 'package:my_notes/screen/addEntry/localWidgets/editing_icon_widget.dart';
import 'package:my_notes/screen/addEntry/localWidgets/entry_header.dart';
import 'package:my_notes/screen/addEntry/localWidgets/mood_row_ui.dart';
import 'package:my_notes/widgets/default_appbar_leading.dart';
import 'package:my_notes/widgets/default_appbar_title.dart';
import 'package:my_notes/widgets/description_textfield.dart';
import 'package:stacked/stacked.dart';

class AddEntryView extends StatefulWidget {
  const AddEntryView({Key? key}) : super(key: key);

  @override
  State<AddEntryView> createState() => _AddEntryViewState();
}

class _AddEntryViewState extends State<AddEntryView> {
  FontWeight fontWeight = FontWeight.normal;
  FontStyle fontStyle = FontStyle.normal;

  // TextAlign textAlign = TextAlign.left;

  @override
  Widget build(BuildContext context) {
    Brightness theme = Theme.of(context).brightness;


    // if (arguments != null && arguments is AddEntryArgs) {
    //   AddEntryArgs args = arguments;
    //   // Use 'args' safely here
    // } else {
    //   // Handle the case where the arguments are null or not of type AddEntryArgs
    //   print('Invalid or missing arguments');
    // }
    return ViewModelBuilder.reactive(

        onViewModelReady: (viewModel) {
          try {
            final arguments =
            ModalRoute.of(context)?.settings.arguments as AddEntryArgs;
            print('i am here for ${arguments.formAction}');
            viewModel.titleController.text = arguments.entry?.title??'';
            viewModel.descriptionController.text = arguments.entry?.description??'';

          } catch (e) {
            print(e);
          }
        },
        viewModelBuilder: () => AddEntryViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              leading: const DefaultAppBarLeading(),
              title: const DefaultAppBarTitle(title: addEntryString),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: Dimens.padding20),
                  child: GestureDetector(
                    onTap: () {
                      _insertData(viewModel, context);
                    },
                    child: const Icon(
                      Icons.save,
                      size: Dimens.iconSize50,
                    ),
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                verticalSpace(10),
                EntryHeader(
                  titleController: viewModel.titleController,
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
                      controller: viewModel.descriptionController,
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
                MoodRowUi(
                  viewModel: viewModel,
                ),
              ],
            ),
          );
        });
  }

  void _insertData(AddEntryViewModel viewModel, context) {
    viewModel.insertNewEntry(
      context: context,
      entry: DiaryEntry(
        title: viewModel.titleController.text,
        description: viewModel.descriptionController.text,
        dateTime: DateTime.now().toString(),
        mood: viewModel.selectedValue,
      ),
    );
  }
}

class AddEntryArgs {
  final FormAction formAction;
  final DiaryEntry? entry;

  AddEntryArgs({required this.formAction, required this.entry});
}
