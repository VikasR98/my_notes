import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/app/image_config.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:my_notes/constants/dimes.dart';
import 'package:my_notes/constants/utils.dart';
import 'package:my_notes/screen/createNote/create_note_viewmodel.dart';
import 'package:my_notes/screen/createNote/localWidgets/editing_icon_widget.dart';
import 'package:my_notes/screen/createNote/localWidgets/entry_header.dart';
import 'package:my_notes/widgets/app_textformfield_new.dart';
import 'package:my_notes/widgets/description_textfield.dart';
import 'package:stacked/stacked.dart';

//
// class CreateNoteBody extends StatefulWidget {
//   final String? lastEditTime;
//   final void Function(String) onChanged;
//   String? selectedMood;
//   TextAlign textAlign;
//   final CreateNoteViewModel viewModel;
//
//   CreateNoteBody({
//     super.key,
//     required this.lastEditTime,
//     required this.onChanged,
//     required this.selectedMood,
//     required this.textAlign,
//     required this.viewModel,
//   });
//
//   @override
//   State<CreateNoteBody> createState() => _CreateNoteBodyState();
// }
//
// class _CreateNoteBodyState extends State<CreateNoteBody> {
//   FontWeight fontWeight = FontWeight.normal;
//   FontStyle fontStyle = FontStyle.normal;
//
//   @override
//   Widget build(BuildContext context) {
//     Brightness theme = Theme.of(context).brightness;
//     return Column(
//       children: [
//         verticalSpace(10),
//         EntryHeader(
//           theme: theme,
//           lastEditTime: widget.lastEditTime,
//           onChanged: widget.onChanged,
//         ),
//         Container(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 20,
//             vertical: 16,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               EditIcon(
//                 iconData: Icons.format_align_left_rounded,
//                 onTap: () {
//                   setState(() {
//                     widget.textAlign = TextAlign.left;
//                     print('left');
//                   });
//                 },
//               ),
//               EditIcon(
//                 iconData: Icons.format_align_center_rounded,
//                 onTap: () {
//                   setState(() {
//                     widget.textAlign = TextAlign.center;
//                     print('centre');
//                   });
//                 },
//               ),
//               EditIcon(
//                 iconData: Icons.format_align_right_rounded,
//                 onTap: () {
//                   setState(() {
//                     // widget.viewModel.textAlign = TextAlign.right;
//                     print('right');
//                   });
//
//                   print('align');
//                 },
//               ),
//               EditIcon(
//                 iconData: Icons.format_bold_rounded,
//                 onTap: () {
//                   setState(() {
//                     if (fontWeight == FontWeight.w900) {
//                       fontWeight = FontWeight.normal;
//                     } else {
//                       fontWeight = FontWeight.w900;
//                     }
//                   });
//                 },
//               ),
//               EditIcon(
//                 iconData: Icons.format_italic_rounded,
//                 onTap: () {
//                   setState(() {
//                     if (fontStyle != FontStyle.italic) {
//                       fontStyle = FontStyle.italic;
//                     } else {
//                       fontStyle = FontStyle.normal;
//                     }
//                   });
//                 },
//               ),
//               EditIcon(
//                 iconData: Icons.format_underline_rounded,
//                 onTap: () {},
//               ),
//             ],
//           ),
//         ),
//         Expanded(
//           child: Container(
//             decoration: BoxDecoration(
//               // color: Colors.amber,
//               color: theme == Brightness.light
//                   ? AppColors.appWhite
//                   : AppColors.darkModeSecondaryColor,
//               borderRadius: BorderRadius.only(
//                 topLeft: Dimens.entryDescriptionBorderRadius(),
//                 topRight: Dimens.entryDescriptionBorderRadius(),
//               ),
//             ),
//             child: DescriptionTextField(
//               fontWeight: fontWeight,
//               fontStyle: fontStyle,
//               textAlign: widget.textAlign,
//               onChanged: widget.onChanged,
//             ),
//           ),
//         ),
//         Container(
//           // height: 80,
//           padding: const EdgeInsets.symmetric(
//             horizontal: 30,
//             vertical: 10,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Mood',
//                 style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//               ),
//               Row(
//                 children: [
//                   MoodEmojiWidget(
//                     selectedMood: widget.selectedMood,
//                     onTap: () {
//                       widget.selectedMood = 'happinessEmoji';
//                     },
//                     iconName: happinessEmoji,
//                   ),
//                   MoodEmojiWidget(
//                     selectedMood: widget.selectedMood,
//                     onTap: () {
//                       setState(() {
//                         widget.selectedMood = 'neutralEmoji';
//                       });
//                       print('netral');
//                     },
//                     iconName: neutralEmoji,
//                   ),
//                   MoodEmojiWidget(
//                     selectedMood: widget.selectedMood,
//                     onTap: () {
//                       widget.selectedMood = 'confusedEmoji';
//                     },
//                     iconName: confusedEmoji,
//                   ),
//                   MoodEmojiWidget(
//                     selectedMood: widget.selectedMood,
//                     onTap: () {
//                       widget.selectedMood = 'signEmoji';
//                       print('sign');
//                     },
//                     iconName: signEmoji,
//                   ),
//                   MoodEmojiWidget(
//                     selectedMood: widget.selectedMood,
//                     onTap: () {
//                       widget.selectedMood = 'sadEmoji';
//                     },
//                     iconName: sadEmoji,
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

class MoodEmojiWidget extends StatelessWidget {
  const MoodEmojiWidget({
    super.key,
    required this.iconName,
    required this.onTap,
    required this.selectedMood,
    required this.value,
    required this.selectedValue,
  });

  final String iconName;
  final void Function() onTap;
  final String? selectedMood;
  final int value;
  final int selectedValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 25,
        backgroundColor:
            value == selectedValue ? AppColors.primaryColor : Colors.white,
        child: Image.asset(iconName),
      ),
    );
  }

}
