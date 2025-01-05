import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:my_notes/constants/dimes.dart';
import 'package:my_notes/constants/strings.dart';
import 'package:my_notes/constants/utils.dart';
import 'package:my_notes/enum/form_action.dart';
import 'package:my_notes/model/data_entry.dart';
import 'package:my_notes/screen/addEntry/add_entry_viewmodel.dart';
import 'package:my_notes/screen/addEntry/localWidgets/edit_text_tool_row_ui.dart';
import 'package:my_notes/screen/addEntry/localWidgets/entry_header.dart';
import 'package:my_notes/screen/addEntry/localWidgets/mood_row_ui.dart';
import 'package:my_notes/screen/addEntry/localWidgets/save_btn_ui.dart';
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
  @override
  Widget build(BuildContext context) {
    Brightness theme = Theme.of(context).brightness;

    return ViewModelBuilder.reactive(
        onViewModelReady: (viewModel) {
          try {
            final arguments =
                ModalRoute.of(context)?.settings.arguments as AddEntryArgs;
            viewModel.id = arguments.entry?.id;
            viewModel.formAction = arguments.formAction;
            viewModel.titleController.text = arguments.entry?.title ?? '';
            viewModel.descriptionController.text =
                arguments.entry?.description ?? '';

            viewModel.lastEditTime =
                formatDateTime(arguments.entry?.dateTime ?? '');
            viewModel.selectedValue = arguments.entry?.mood ?? 0;
            print(viewModel.lastEditTime);
          } catch (e) {
            if (kDebugMode) {
              print(e);
            }
          }
        },
        viewModelBuilder: () => AddEntryViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              leading: const DefaultAppBarLeading(),
              title: const DefaultAppBarTitle(title: addEntryString),
              actions: [
                SaveButtonUi(viewModel: viewModel),
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
                    viewModel.getLastEditTime(DateTime.now());
                  },
                ),
                EditTextToolUi(viewModel: viewModel),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
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
                      fontWeight: viewModel.fontWeight,
                      fontStyle: viewModel.fontStyle,
                      textAlign: viewModel.textAlign,
                      onChanged: (String value) {
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

}

class AddEntryArgs {
  final FormAction formAction;
  final DiaryEntry? entry;

  AddEntryArgs({required this.formAction, required this.entry});
}
