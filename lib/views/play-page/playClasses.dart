import 'package:audio_service/audio_service.dart';
 class MediaLibrary {
  static List items = <MediaItem>[];
  static void add(MediaItem mediaItem){
    items.clear();
    items.add(mediaItem);
  }

}