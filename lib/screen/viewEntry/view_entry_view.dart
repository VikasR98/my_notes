import 'package:flutter/material.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:my_notes/constants/dimes.dart';
import 'package:my_notes/constants/routes.dart';
import 'package:my_notes/constants/strings.dart';
import 'package:my_notes/constants/utils.dart';
import 'package:my_notes/enum/form_action.dart';
import 'package:my_notes/model/data_entry.dart';
import 'package:my_notes/model/mood_mapping.dart';
import 'package:my_notes/screen/addEntry/add_entry_view.dart';
import 'package:my_notes/screen/viewEntry/view_entry_viewmodel.dart';
import 'package:my_notes/screen/viewEntry/widgets/view_entry_header.dart';
import 'package:my_notes/widgets/default_appbar_leading.dart';
import 'package:my_notes/widgets/default_appbar_title.dart';
import 'package:my_notes/widgets/description_textfield.dart';
import 'package:stacked/stacked.dart';

class ViewEntryView extends StatefulWidget {
  const ViewEntryView({super.key});

  @override
  State<ViewEntryView> createState() => _ViewEntryViewState();
}

class _ViewEntryViewState extends State<ViewEntryView> {
  late DiaryEntry entry;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Brightness theme = Theme.of(context).brightness;
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) {
        entry = ModalRoute.of(context)?.settings.arguments as DiaryEntry;
        controller.text = entry.description;
        print(entry.title);
      },
      viewModelBuilder: () => ViewEntryViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            leading: const AppBarBackArrow(),
            title: const DefaultAppBarTitle(title: viewEntryString),
          ),
          floatingActionButton: EditEntryFloatingBtn(
            viewModel: viewModel,
            entry: entry,
          ),
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: ViewEntryHeaderUi(entry: entry),
              ),
              Expanded(
                flex: 4,
                child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 50,
                      left: 30,
                      right: 30,
                    ),
                    decoration: BoxDecoration(
                      color: theme == Brightness.light
                          ? AppColors.appWhite
                          : AppColors.darkModeSecondaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Dimens.entryDescriptionBorderRadius(),
                        topRight: Dimens.entryDescriptionBorderRadius(),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        entry.description,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              height: 1.4,
                              // fontWeight: fontWeight,
                              // fontStyle: fontStyle,
                            ),
                      ),
                    )),
              )
            ],
          ),
        );
      },
    );
  }
}

class EditEntryFloatingBtn extends StatelessWidget {
  final ViewEntryViewModel viewModel;
  final DiaryEntry entry;

  const EditEntryFloatingBtn({
    super.key,
    required this.viewModel,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(
          context,
          addEntryRoute,
          arguments: AddEntryArgs(
            formAction: FormAction.edit,
            entry: entry,
          ),
        );
      },
      child: const CircleAvatar(
        radius: 30,
        backgroundColor: AppColors.primaryColor,
        child: Icon(
          Icons.mode_edit_rounded,
          size: 35,
          color: AppColors.appWhite,
        ),
      ),
    );
  }
}
