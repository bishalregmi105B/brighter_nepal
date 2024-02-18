import 'package:brighter_nepal/models/videos_modal.dart';

List<Videos> filterVideosByType(List<Videos> videos, String desiredType) {
  return videos.where((video) => video.type == desiredType).toList();
}
