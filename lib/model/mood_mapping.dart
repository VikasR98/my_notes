import 'package:my_notes/app/image_config.dart';

class Mood {
  static String moodToEmoji(int mood) {
    switch (mood) {
      case 2:
        return happy;
      case 4:
        return sad;
      case 3:
        return normal;
      case 1:
        return laugh;
      case 5:
        return cry;
      default:
        return "Unknown";
    }
  }
}
