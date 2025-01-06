import 'package:flutter/material.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:my_notes/constants/dimes.dart';
import 'package:my_notes/constants/strings.dart';
import 'package:my_notes/constants/utils.dart';
import 'package:my_notes/model/data_entry.dart';
import 'package:my_notes/model/mood_mapping.dart';
import 'package:my_notes/screen/viewEntry/view_entry_viewmodel.dart';
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
          body: Column(
            children: [
              ViewEntryHeaderUi(entry: entry),
              Expanded(
                child: Container(
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
                        style:
                            Theme.of(context).textTheme.titleLarge?.copyWith(
                                  height: 1.4,
                                  // fontWeight: fontWeight,
                                  // fontStyle: fontStyle,
                                ),
                      ),
                    )
                    // child: DescriptionTextField(
                    //   enabled: false,
                    //   controller: controller,
                    //   fontWeight: FontWeight.normal,
                    //   fontStyle: FontStyle.normal,
                    //   textAlign: TextAlign.left,
                    //   onChanged: (String value) {
                    //     // viewModel.getLastEditTime(DateTime.now());
                    //   },
                    // ),
                    ),
              )
            ],
          ),
        );
      },
    );
  }
}

class ViewEntryHeaderUi extends StatelessWidget {
  const ViewEntryHeaderUi({
    super.key,
    required this.entry,
  });

  final DiaryEntry entry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.title,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
                Text(
                  formatDateTime(entry.dateTime),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                Mood.moodToEmoji(entry.mood),
                height: 80,
              ),
            ),
          )
        ],
      ),
    );
  }
}
