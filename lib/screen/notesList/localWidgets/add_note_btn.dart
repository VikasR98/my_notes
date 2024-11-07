import 'package:flutter/material.dart';
import 'package:my_notes/constants/colors.dart';
import 'package:my_notes/constants/dimes.dart';
import 'package:my_notes/screen/createNote/create_note_view.dart';

class AddEntryBtn extends StatelessWidget {
  const AddEntryBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,

            ///[MaterialPageRoute] transitions between routes with
            ///platform specific animations (android and ios)
            MaterialPageRoute(builder: (context) => const CreateNoteView()));
      },
      child: const CircleAvatar(
        radius: 30,
        backgroundColor: AppColors.primaryColor,
        child: Icon(
          Icons.book,
          size: 35,
          color: AppColors.appWhite,
        ),
      ),
    );
  }
}
